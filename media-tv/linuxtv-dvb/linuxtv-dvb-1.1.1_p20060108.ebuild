# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/linuxtv-dvb/linuxtv-dvb-1.1.1_p20060108.ebuild,v 1.6 2007/01/05 17:07:37 hd_brummy Exp $

inherit eutils linux-mod

MY_PV=${PV#*_p}

DVB_TTPCI_FW="dvb-ttpci-01.fw-2622"
DESCRIPTION="Standalone DVB driver for Linux kernel 2.4.x"
HOMEPAGE="http://www.linuxtv.org"
SRC_URI="mirror://gentoo/dvb-kernel_linux_2_4-${MY_PV}.tar.bz2
	http://www.linuxtv.org/download/dvb/firmware/${DVB_TTPCI_FW}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha x86"
IUSE=""
DEPEND="virtual/linux-sources"
RDEPEND=""

S=${WORKDIR}/dvb-kernel/build-2.4

pkg_setup() {
	linux-mod_pkg_setup
	if [[ ${KV_MAJOR}.${KV_MINOR} != 2.4 ]]; then
		elog "This ebuild only provides drivers for Kernel 2.4"
		elog "Kernel 2.6 has included drivers for DVB devices."
		elog "please use these"
		die "Kernel 2.6 not supported"
	fi

	elog "Please make sure that the following option is enabled"
	elog "in your current kernel 'Multimedia devices'"
	elog "and /usr/src/linux points to your current kernel"
	elog "or make will die."
	elog
	MODULE_NAMES="dvb(dvb:${S})"
	BUILD_PARAMS="KDIR=${KERNEL_DIR}"
	BUILD_TARGETS="build"
}

src_unpack() {
	unpack ${A}
	cp ${DISTDIR}/${DVB_TTPCI_FW} ${S}/dvb-ttpci-01.fw
}

src_install() {
	#copy over the insmod.sh script
	#for loading all modules
	sed -e "s:insmod ./:modprobe :" -i insmod.sh
	sed -e "s:.${KV_OBJ}::" -i insmod.sh
	newsbin insmod.sh dvb-module-load

	# install the modules
	make install DESTDIR="${D}" DEST="/lib/modules/${KV_FULL}/dvb"

	# install the header files
	cd ${S}/../linux/include/linux/dvb
	insinto /usr/include/linux/dvb
	doins *.h

	#install the main docs
	cd ${S}
	dodoc MAKEDEV-DVB.sh NEWS README README.bt8xx TODO TROUBLESHOOTING

	#install the other docs
	cd ${S}/doc
	dodoc HOWTO-use-the-demux-api \
	README.valgrind HOWTO-use-the-frontend-api \
	convert.sh valgrind-2.1.0-dvb.patch
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog "If you don't use devfs, execute MAKEDEV-DVB.sh to create"
	elog "the device nodes. The file is in /usr/share/doc/${PF}/"
	elog
	elog "A file called dvb-module-load has been created to simplify loading all modules."
	elog "Call it using 'dvb-module-load {load|debug|unload}'."
	elog
	elog "For information about firmware please see /usr/share/doc/${PF}/README."
	elog
	elog "Firmware-files can be found in media-tv/linuxtv-dvb-firmware"
	elog
}
