build:
	@echo 'Nothing to build'

install:
	mkdir -p ${DESTDIR}/usr/{lib/systemd/system,{libexec,share}/discord-installer}
	install -m 644 discord-installer.{service,timer} ${DESTDIR}/usr/lib/systemd/system
	install -m 644 discord-canary-installer.{service,timer} ${DESTDIR}/usr/lib/systemd/system
	install -m 755 build.sh ${DESTDIR}/usr/libexec/discord-installer
	install -m 644 template.spec ${DESTDIR}/usr/share/discord-installer

clean:
	rm -rf ${DESTDIR}/*

.PHONY: build install clean