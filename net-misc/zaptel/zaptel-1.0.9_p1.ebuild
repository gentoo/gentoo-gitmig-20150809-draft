# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zaptel/zaptel-1.0.9_p1.ebuild,v 1.2 2005/08/18 17:55:09 stkn Exp $

IUSE="devfs26 bri florz rtc"

inherit toolchain-funcs eutils linux-mod

BRI_VERSION="0.2.0-RC8l"
FLORZ_VERSION="0.2.0-RC8j_florz-8"

MY_PV="${PV/_p/.}"

DESCRIPTION="Drivers for Digium and ZapataTelephony cards"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/zaptel/zaptel-${MY_PV}.tar.gz
	 bri? ( http://www.junghanns.net/downloads/bristuff-${BRI_VERSION}.tar.gz )
	 florz? ( http://zaphfc.florz.dyndns.org/zaphfc_${FLORZ_VERSION}.diff.gz )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="virtual/libc
	virtual/linux-sources
	>=dev-libs/newt-0.50.0"

S="${WORKDIR}/${PN}-${MY_PV}"

pkg_setup() {
	linux-mod_pkg_setup

	# show an nice warning message about zaptel not supporting devfs on 2.6
	if kernel_is 2 6 && linux_chkconfig_present DEVFS_FS ; then
		echo
		einfo "You're using a 2.6 kernel with DEVFS."
		einfo "The Zaptel drivers won't work unless you either:"
		einfo "   * switch to udev"
		einfo "   * write a script that re-creates the necessary device nodes for you"
		einfo "   * enable the devfs26 useflag (see below)"
		einfo ""
		einfo "There's an experimental patch which adds devfs support when using linux-2.6, but:"
		einfo "   1. It disables udev support to avoid conflicts"
		ewarn "   2. It is not supported by Digium / the Asterisk project!"
		einfo ""
		einfo "If you're still interested, abort now (ctrl+c) and enable the devfs26 USE-flag"
		einfo "Feedback and bug-reports should go to: stkn@gentoo.org"
		einfo "You have been warned!"
		echo
		einfo "Sleeping 20 Seconds..."
		epause 20
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# patch makefile(s) for gentoo
	epatch ${FILESDIR}/${PN}-1.0.9-gentoo.diff

	# devfs support
	if use devfs26; then
		einfo "Enabling experimental devfs support for linux-2.6..."
		epatch ${FILESDIR}/${PN}-1.0.4-experimental-devfs26.diff

		# disable udev
		sed -i -e "s:#define[\t ]\+\(CONFIG_ZAP_UDEV\):#undef \1:" \
			zconfig.h
	fi

	# apply patch for gcc-3.4.x if that's the compiler in use...
	# fixes (#76707)
	if use x86 && [[ `gcc-fullversion` = "3.4.3" ]]; then
		epatch ${FILESDIR}/${PN}-1.0.4-gcc34.patch
	fi

	# try to apply bristuff patch
	if use bri; then
		einfo "Patching zaptel w/ BRI stuff (${BRI_VERSION})"
		epatch ${FILESDIR}/zaptel-bristuff-${BRI_VERSION}.patch

		cd ${WORKDIR}/bristuff-${BRI_VERSION}

		if use florz; then
			einfo "Using florz patches (${FLORZ_VERSION}) for zaphfc"

			epatch ${WORKDIR}/zaphfc_${FLORZ_VERSION}.diff
		fi

		# patch includes
		sed -i  -e "s:^#include.*zaptel\.h.*:#include <zaptel.h>:" \
			qozap/qozap.c \
			zaphfc/zaphfc.c \
			cwain/cwain.c

		# patch makefiles
		sed -i  -e "s:^ZAP[\t ]*=.*:ZAP=-I${S}:" \
			-e "s:^MODCONF=.*:MODCONF=/etc/modules.d/zaptel:" \
			-e "s:linux-2.6:linux:g" \
			qozap/Makefile \
			zaphfc/Makefile \
			cwain/Makefile

		sed -i  -e "s:^\(CFLAGS+=-I. \).*:\1 \$(ZAP):" \
			zaphfc/Makefile
	fi

	# replace `uname -r` with ${KV_FULL} in all Makefiles
	find ${WORKDIR} -iname "Makefile" -exec sed -i -e "s:\`uname -r\`:${KV_FULL}:g" {} \;

	cd ${S}
	#######################################################################
	# apply other patches here,
	# make sure they work with things that have been added before!
	#

	# apply x86 rtc patch for ztdummy (http://bugs.digium.com/view.php?id=4301)
	# this won't have any effect on non-x86 systems...
	if use rtc; then
		if use x86 || use amd64; then
			epatch ${FILESDIR}/${PN}-1.0.9-rtc.patch
		else
			ewarn "RTC is unsupported on your arch, skipping patch"
		fi
	fi
}

src_compile() {
	make ARCH=$(tc-arch-kernel) KERNEL_SOURCE=/usr/src/linux || die

	if use bri; then
		cd ${WORKDIR}/bristuff-${BRI_VERSION}
		make ARCH=$(tc-arch-kernel) -C qozap  || die
		make ARCH=$(tc-arch-kernel) -C zaphfc || die
		make ARCH=$(tc-arch-kernel) -C cwain  || die
	fi
}

src_install() {
	make INSTALL_PREFIX=${D} install || die

	dodoc ChangeLog README README.udev README.Linux26 README.fxsusb zaptel.init
	dodoc zaptel.conf.sample LICENSE zaptel.sysconfig

	# additional tools
	dobin ztmonitor ztspeed zttest

	if use bri; then
		einfo "Installing bri"
		cd ${WORKDIR}/bristuff-${BRI_VERSION}

		insinto /lib/modules/${KV_FULL}/misc
		doins qozap/qozap.${KV_OBJ}
		doins zaphfc/zaphfc.${KV_OBJ}
		doins cwain/cwain.${KV_OBJ}

		# install example configs for octoBRI and quadBRI
		insinto /etc
		doins qozap/zaptel.conf.octoBRI
		newins qozap/zaptel.conf zaptel.conf.quadBRI
		newins zaphfc/zaptel.conf zaptel.conf.zaphfc

		insinto /etc/asterisk
		doins qozap/zapata.conf.octoBRI
		newins qozap/zapata.conf zapata.conf.quadBRI
		newins zaphfc/zapata.conf zapata.conf.zaphfc

		docinto bristuff
		dodoc CHANGES INSTALL

		docinto bristuff/qozap
		dodoc qozap/LICENSE qozap/TODO qozap/*.conf*

		docinto bristuff/zaphfc
		dodoc zaphfc/LICENSE zaphfc/*.conf

		docinto bristuff/cwain
		dodoc cwain/TODO cwain/LICENSE
	fi

	# install init script
	newinitd ${FILESDIR}/zaptel.rc6 zaptel
	newconfd ${FILESDIR}/zaptel.confd zaptel

	# install devfsd rule file
	insinto /etc/devfs.d
	newins ${FILESDIR}/zaptel.devfsd zaptel

	# install udev rule file
	insinto /etc/udev/rules.d
	newins ${FILESDIR}/zaptel.udevd 10-zaptel.rules

	# fix permissions if there's no udev / devfs around
	if [[ -d ${D}/dev/zap ]]; then
		chown -R root:dialout	${D}/dev/zap
		chmod -R u=rwX,g=rwX,o= ${D}/dev/zap
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

	if use devfs26; then
		ewarn "*** Warning! ***"
		ewarn "Devfs support for linux-2.6 is experimental and not"
		ewarn "supported by digium or the asterisk project!"
		echo
		ewarn "Send bug-reports to: stkn@gentoo.org"
	fi

	echo
	einfo "Use the /etc/init.d/zaptel script to load zaptel.conf settings on startup!"
	echo

	if use bri; then
		einfo "Bristuff configs have been merged as:"
		einfo ""
		einfo "${ROOT}etc/"
		einfo "    zaptel.conf.zaphfc"
		einfo "    zaptel.conf.quadBRI"
		einfo "    zaptel.conf.octoBRI"
		einfo ""
		einfo "${ROOT}etc/asterisk/"
		einfo "    zapata.conf.zaphfc"
		einfo "    zapata.conf.quadBRI"
		einfo "    zapata.conf.octoBRI"
		echo
	fi

	# fix permissions if there's no udev / devfs around
	if [[ -d ${ROOT}/dev/zap ]]; then
		chown -R root:dialout	${ROOT}/dev/zap
		chmod -R u=rwX,g=rwX,o= ${ROOT}/dev/zap
	fi
}
