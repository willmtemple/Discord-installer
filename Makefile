build:
	@echo 'Nothing to build'

install:
	mkdir -p ${DESTDIR}/usr/{lib/systemd/system,{libexec,share}/discord-installer}
	install -m 755 discord-installer.service ${DESTDIR}/usr/lib/systemd/system
	install -m 755 discord-canary-installer.service ${DESTDIR}/usr/lib/systemd/system
	install -m 755 build.sh ${DESTDIR}/usr/libexec/discord-installer
	install -m 755 template.spec ${DESTDIR}/usr/share/discord-installer

clean:
	rm -rf ${DESTDIR}/*

.PHONY: build install clean