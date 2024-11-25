# Use official Golang image for building
FROM golang:1.23.1-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies
RUN apk add --no-cache git gcc musl-dev libpcap-dev

# Install ProjectDiscovery tools and gowitness
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
RUN go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
RUN go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
RUN go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
RUN go install -v github.com/projectdiscovery/katana/cmd/katana@latest

# Create final runtime image
FROM alpine:latest

# Set working directory
WORKDIR /app

# Add a non-root user
RUN adduser -D -H -s /bin/sh appuser \
    && mkdir -p /app/results /home/appuser/.config \
    && chown -R appuser:appuser /app /home/appuser/.config

# Install required runtime dependencies
RUN apk add --no-cache libpcap

# Copy binaries from builder
COPY --from=builder /go/bin/* /usr/local/bin/

# Copy configuration files from a correct directory in your build context
COPY ./subfinder_config.yaml /home/appuser/.config/subfinder/subfinder_config.yaml

# Ensure nuclei templates are updated and appuser has permissions
RUN mkdir -p /home/appuser/.config/nuclei && chown -R appuser:appuser /home/appuser/.config && nuclei -update-templates

# Switch to non-root user
USER appuser

# Expose volume for results
VOLUME /app/results

# Entry point for recon
ENTRYPOINT ["sh", "-c", "\
    subfinder -d $TARGET -o /app/results/subdomains.txt; \
    naabu -list /app/results/subdomains.txt -o /app/results/ports.txt; \
    dnsx -l /app/results/subdomains.txt -o /app/results/resolved.txt; \
    httpx -l /app/results/resolved.txt -o /app/results/httpx_output.txt; \
    katana -list /app/results/resolved.txt -jc  -o /app/results/urls.txt; \
    nuclei -l /app/results/httpx_output.txt -o /app/results/nuclei_output.txt;"]
