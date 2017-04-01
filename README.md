# Discord-installer
<a href="https://copr.fedorainfracloud.org/coprs/tcg/discord/package/Discord-installer/"><img src="https://copr.fedorainfracloud.org/coprs/tcg/discord/package/Discord-installer/status_image/last_build.png" /></a>

## What is it ?
This is a pair of systemd services, an almost complete specfile and a build script to automate the creation, installation and update of the linux [Discord](https://discordapp.com) app.

## Why ?
At first I wanted to make a simple Discord RPM package. However Discord is not free software, and I neither have the right to redistribute it nor the right to build it on [Fedora Copr](https://copr.fedorainfracloud.org). This is where the installer does its magic: Discord is not in the package, but is rather downloaded by the end user directly; solving both problems at once.
