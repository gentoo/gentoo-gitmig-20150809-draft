# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ltmodem/ltmodem-8.31_alpha10.ebuild,v 1.2 2005/03/18 06:38:05 mrness Exp $

inherit linux-mod

MY_P="${P/_alpha/a}"
DESCRIPTION="Winmodems with Lucent Apollo (ISA) and Mars (PCI) chipsets"
HOMEPAGE="http://www.heby.de/ltmodem/"
SRC_URI="http://www.physcip.uni-stuttgart.de/heby/ltmodem/${MY_P}.tar.gz
	http://www.sfu.ca/~cth/ltmodem/${MY_P}.tar.gz
	http://linmodems.technion.ac.il/packages/ltmodem/kernel-2.6/ltmodem-2.6-alk-7.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nouserpriv"

S=${WORKDIR}/${PN}-2.6-alk-7
S_2_4=${WORKDIR}/${MY_P}

DEPEND="sys-apps/util-linux"

MODULE_NAMES="ltmodem(ltmodem:) ltserial(ltmodem:)"
BUILD_TARGETS="module"
BUILD_PARAMS="KERNEL_DIR=${KV_DIR}"
MODULESD_LTMODEM_ALIASES=( "char-major-62 ltserial"
	"/dev/tts/LT0  ltserial"
	"/dev/modem ltserial" )

pkg_setup() {
	if kernel_is 2 4; then
		CONFIG_CHECK="SERIAL"
		SERIAL_8250_ERROR="This driver requires you to compile your kernel with serial core (CONFIG_SERIAL) support."
	else
		CONFIG_CHECK="SERIAL_8250"
		SERIAL_8250_ERROR="This driver requires you to compile your kernel with serial core (CONFIG_SERIAL_8250) support."
	fi
	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}
	convert_to_m ${S}/Makefile
}

src_compile() {
	if kernel_is 2 4; then
		cd ${S_2_4}
		sed -i -e 's:make -e:make:' -e 's:read -p:echo:' build_module
		FAST="1" ./build_module ${KV_FULL} || die "Compilation filed"
	else
		linux-mod_src_compile
	fi
}

src_install() {
	# install docs
	cd ${S_2_4}/DOCs
	dohtml *.html

	rm -rf *.html Installers build* Build* gcc3.txt Examples Suse*
	rm -rf fixscript* slackware srcprep.man scanmodem.man conf*

	rename .man .1 *.man
	doman *.1
	rm -rf *.1

	dodoc ../1ST-READ *
	cd ..

	# install utilities
	mv utils/unloading utils/lt_unloading
	dosbin utils/lt_*

	# install configuration
	insinto /etc/devfs.d
	newins ${FILESDIR}/ltmodem_devfs ltmodem

	# install kernel module
	if kernel_is 2 4; then
		cd source
		make install ROOTDIR=${D} || die "Cannot install drivers"
	else
		linux-mod_src_install
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

	# Make some devices if we aren't using devfs
	if [ -e ${ROOT}/dev/.devfsd ]; then
		ebegin "Restarting devfsd to reread devfs rules"
			killall -HUP devfsd
		eend $?
		einfo "modules-update to complete configuration."

		einfo "Use /dev/tts/LT0 or /dev/ttyLT0 to access modem"
	elif [ -e ${ROOT}/dev/.udev ]; then
		ebegin "Restarting udev to reread udev rules"
			udevstart
		eend $?

		einfo "Use /dev/ttyLTM0 to access modem"
	fi

	einfo
	ewarn "Remember, in order to access the modem,"
	ewarn "you have to be in the 'dialout' group."
	ewarn "Also, if your dialing application use locking mechanism (e.g wvdial),"
	ewarn "you should have write access to /var/lock directory."
	einfo
	einfo "If you have problems, read this doc:"
	einfo "/usr/share/doc/${PF}/html/post-install.html"
}
