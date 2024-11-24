# Use the official Golang image as the base image
FROM golang:1.23.1-alpine as builder

# Set the working directory
WORKDIR /app

# Install necessary dependencies
RUN apk add --no-cache git

# Install subfinder
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Install amass version 4.0.4
RUN go install -v github.com/owasp-amass/amass/v4/...@master

# Install gau
RUN go install github.com/lc/gau/v2/cmd/gau@latest

# Install waybackurls
RUN go install github.com/tomnomnom/waybackurls@latest

# Install httpx
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# Install nuclei
RUN go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Install gowitness
RUN go install github.com/sensepost/gowitness@latest

# Create a new stage from the base image
FROM alpine:latest

# Set the working directory
WORKDIR /app

# Create a non-root user
RUN adduser -D -H -s /bin/sh appuser

# Copy the installed binaries from the builder stage
COPY --from=builder /go/bin/subfinder /usr/local/bin/subfinder
COPY --from=builder /go/bin/amass /usr/local/bin/amass
COPY --from=builder /go/bin/gau /usr/local/bin/gau
COPY --from=builder /go/bin/waybackurls /usr/local/bin/waybackurls
COPY --from=builder /go/bin/httpx /usr/local/bin/httpx
COPY --from=builder /go/bin/nuclei /usr/local/bin/nuclei
COPY --from=builder /go/bin/gowitness /usr/local/bin/gowitness

# Create the directory for subfinder configuration
RUN mkdir -p /home/appuser/.config/subfinder

# Copy the default subfinder configuration file
COPY subfinder_config.yaml /home/appuser/.config/subfinder/config.yaml

# Create a directory for results
RUN mkdir -p /app/results

# Change ownership of the binaries, configuration file, and results directory to the non-root user
RUN chown -R appuser:appuser /usr/local/bin /home/appuser/.config /app/results

# Ensure the results directory has the correct permissions
RUN chmod -R 777 /app/results

# Switch to the non-root user
USER appuser

# Set the entrypoint to execute the provided command
ENTRYPOINT ["sh", "-c", "subfinder -d $TARGET -o /app/results/subfinder_results.txt && \
amass enum -d $TARGET -o /app/results/amass_results.txt && \
gau --subs --o /app/results/gau_results.txt $TARGET && \
waybackurls $TARGET > /app/results/waybackurls_results.txt && \
cat /app/results/subfinder_results.txt /app/results/amass_results.txt /app/results/gau_results.txt /app/results/waybackurls_results.txt | sort -u > /app/results/combined_results.txt && \
httpx -l /app/results/combined_results.txt -o /app/results/httpx_output.txt && \
nuclei -l /app/results/httpx_output.txt -o /app/results/nuclei_output.txt && \
gowitness file -f /app/results/httpx_output.txt --screenshot-path=/app/results/screenshots"]

# Add a health check (optional, depending on your use case)
HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl --fail http://localhost || exit 1
