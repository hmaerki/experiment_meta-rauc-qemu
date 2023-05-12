CONFIG_FILE := "${THISDIR}/files/config.conf.qemu-demo"

do_install:append () {
	install -d ${D}${sysconfdir}/${PN}
	install -m 644 ${CONFIG_FILE} ${D}${sysconfdir}/${PN}/config.conf
}
