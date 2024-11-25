<p align="center"><a href="https://x.com/xyizko" target="_blank" rel="noopener noreferrer"><img src="https://raw.githubusercontent.com/xyizko/xo-tagz/refs/heads/main/gfx/a.png"></a></p>

<p align="center">
<a href="https://twitter.com/xyizko" target="_blank">
<img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fxyizko%2Fxo-bbr-1&count_bg=%23313B2A&title_bg=%233B0404&icon=&icon_color=%23E7E7E7&title=%F0%9F%91%81%EF%B8%8F&edge_flat=false"/>
</a>

<p align="center"><a href="https://x.com/xyizko" target="_blank" rel="noopener noreferrer"><img src="./gfx/1.webp" width="1200">
</a></p>

<h1 align="center"><code>xo-bbr-1</code></h1>
<h2 align="center"><i>Recon Bug Bounty Automation Script</i></h2>

1. [🤔What](#what)
2. [🍬 Tools Used](#-tools-used)
3. [🦧 Usage](#-usage)
4. [⚠️ WARNING](#️-warning)

# 🤔What

Recon bug bounty automation script in Docker

> [!CAUTION]
> Usage for CTF and BB Competitions only. This script is very noisy and will trigger EDR's 

# 🍬 Tools Used 

> [!NOTE]
> This dockerfile chains the following opens source utilities

Famiiliary with the following tools is compulsory for tweaking and customizations

1. [`httpx`](https://github.com/projectdiscovery/httpx) - HTTP Toolkit
2. [`nuclei`](https://github.com/projectdiscovery/nuclei) - High Performance Vulnerability Scanner
3. [`subfinder`](https://github.com/projectdiscovery/subfinder) - Subdomain Enumeration
4. [`naabu`](https://github.com/projectdiscovery/naabu) - Portscanner
5. [`dnxs`](https://github.com/projectdiscovery/dnsx) - Multipurpose DNS Toolkit
6. [`katana`](https://github.com/projectdiscovery/katana) - Crawling and Spidering

# 🦧 Usage

1. Clone Repository 

2. Make script executable and execute

```sh 
chmod +x runbb.sh 
./runbb.sh example.com
```

3. Results will be written to the `results` folder

> [!IMPORTANT]
> This is a comprehensive script whose timing depends on the complexity of site. Please read the documentation for scoping and time-boxing.

4. After completing usage you can prune all docker artifacts with `dc.sh`

```sh 
chmod +x dc.sh
./dc.sh
```
> [!IMPORTANT]
> This will stop and prune ALL docker artifacts. Do not use if you have other docker containers running


# ⚠️ WARNING 

[![](./gfx/w.webp)](https://x.com/xyizko)

> [!CAUTION]
> For educational and competitions only. Usage on unauthorized sites is illegal. 