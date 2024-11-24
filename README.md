<p align="center"><a href="https://x.com/xyizko" target="_blank" rel="noopener noreferrer"><img src="https://raw.githubusercontent.com/xyizko/xo-tagz/refs/heads/main/gfx/a.png"></a></p>

<p align="center">
<a href="https://twitter.com/xyizko" target="_blank">
<img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fxyizko%2Fxo-bbr-1&count_bg=%23313B2A&title_bg=%233B0404&icon=&icon_color=%23E7E7E7&title=%F0%9F%91%81%EF%B8%8F&edge_flat=false"/>
</a>

<p align="center">
<img src="./gfx/1.webp" width="1200">
</p>

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

Famiiliary with the following tools is compulsory to make any tweaks and customization

1. [`Subfinder`](https://github.com/projectdiscovery/subfinder) - Fast passive sundomain enumeration 
2. [`Amass`](https://github.com/projectdiscovery/subfinder) - Attack Surface Mapping
3. [`Gau`](https://github.com/lc/gau) - URL Enumeration 
4. [`waybackurls`](https://github.com/tomnomnom/waybackurls) - URL enumeration from [`waybackmachine`](https://web.archive.org/)
5. [`httpx`](https://github.com/projectdiscovery/httpx) - HTTP Toolkit
6. [`nuclei`](https://github.com/projectdiscovery/nuclei) _ High Performance Vulnerability Scanner
7. [`gowitness`](https://github.com/sensepost/gowitness) - Chrome Headless Screenshots

# 🦧 Usage

1. Clone Repository 

2. Make script executable and execute

```sh 
chmod +x runbb.sh 
./runbb.sh example.com
```

3. Results will be written to the `results` folder

> [!IMPORTANT]
> This is a comprehensive script which takes a long time to finish based on the complexity of the site. Even though it is written in golang.

4. After completing usage you can prune all docker artifacts

```sh 
chmod +x dc.sh
./dc.sh
```
> [!IMPORTANT]
> This will stop and prune ALL docker artifacts. Do not use if you have other docker containers running


# ⚠️ WARNING 

![](./gfx/w.webp)

> [!CAUTION]
> For educational and competitions only. Usage on unauthorized site is illegal. 