# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zaptel/zaptel-1.0.4-r1.ebuild,v 1.2 2005/06/25 13:26:54 stkn Exp $

IUSE="devfs26"

inherit toolchain-funcs eutils linux-info

DESCRIPTION="Drivers for Digium and ZapataTelephony cards"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/zaptel/old/zaptel-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="virtual/libc
	virtual/linux-sources
	>=dev-libs/newt-0.50.0"

pkg_setup() {
	local pause_sec=0
	linux-info_pkg_setup

	if ! linux_chkconfig_present PPP ; then
		einfo ""
		einfo "PPP support isn't enabled or available as a module."
		einfo ""

		einfo "If you aren't using PPP (eg. you're using voice ISDN"
		einfo "or non-PPP data), then this is okay."

		einfo "Otherwise, if you want to use PPP over your hardware"
		einfo "please quit now and reconfigure your kernel to include"
		einfo "CONFIG_PPP, CONFIG_PPP_ASYNC, CONFIG_PPP_DEFLATE"
		einfo "and CONFIG_PPPOE."
		einfo ""
		pause_sec=10
	fi

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
		einfo "  1. It's an ugly hack atm and needs a cleanup..."
		einfo "  2. I was only abled to test loding / unloading with the ztd-eth driver..."
		einfo "  3. I _really_ don't know if it works with real hardware..."
		einfo "  4. It disables udev support to avoid conflicts"
		eerror "  5. And more important: This is not officially supported by Digium / the Asterisk project!"
		einfo ""
		einfo "If you're still interested, abort now (ctrl+c) and enable the devfs26 USE-flag"
		einfo "Feedback and bug-reports should go to: stkn@gentoo.org"
		einfo "You have been warned!"
		echo
		pause_sec=$(($pause_sec + 20))
	fi

	# wait once, not multiple times
	if [[ $pause_sec -gt 0 ]]; then
		einfo "Sleeping $pause_sec seconds"
		epause $pause_sec
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# >= 1.0.3 requires new patch (-modulesd patch renamed to -gentoo)
	epatch ${FILESDIR}/${PN}-1.0.3-gentoo.diff

	# remove all from install target
	sed -i -e "s#^\(install:\)[ \t]\+all[ \t]\+\(.*\)#\1 \2#" Makefile

	# enable ztdummy...
	sed -i -e "s:#\( ztdummy.*\):\1:" Makefile

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
		epatch ${FILESDIR}/${P}-gcc34.patch
	fi
}

src_compile() {
	set_arch_to_kernel
	make || die
	set_arch_to_portage
}

src_install() {
	make INSTALL_PREFIX=${D} install || die

	dodoc ChangeLog README README.udev README.Linux26 README.fxsusb zaptel.init
	dodoc zaptel.conf.sample LICENSE zaptel.sysconfig

	# additional tools
	dobin ztmonitor ztspeed zttest

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
		chown -R root:dialout   ${D}/dev/zap
		chmod -R u=rwX,g=rwX,o= ${D}/dev/zap
	fi
}

pkg_postinst() {
	if use devfs26; then
		ewarn "*** Warning! ***"
		ewarn "Devfs support for linux-2.6 is experimental and not"
		ewarn "supported by digium or the asterisk project!"
		echo
		ewarn "Send bug-reports to: stkn@gentoo.org"
	fi

	echo
	einfo "Use the /etc/init.d/zaptel script to load zaptel.conf settings on startup!"

	# fix permissions if there's no udev / devfs around
	if [[ -d ${ROOT}/dev/zap ]]; then
		chown -R root:dialout   ${ROOT}/dev/zap
		chmod -R u=rwX,g=rwX,o= ${ROOT}/dev/zap
	fi
}
