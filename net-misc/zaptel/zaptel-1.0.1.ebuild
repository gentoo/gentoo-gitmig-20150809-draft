# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zaptel/zaptel-1.0.1.ebuild,v 1.1 2004/10/26 01:42:03 stkn Exp $

IUSE="devfs26"

inherit eutils kernel-mod

DESCRIPTION="Pseudo-TDM engine"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/zaptel/zaptel-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/libc
	virtual/linux-sources
	>=dev-libs/newt-0.50.0"

pkg_setup() {
	einfo "Please make sure that your kernel has the appropriate"
	einfo "ppp support enabled or present as modules before merging"
	einfo "e.g."
	einfo "CONFIG_PPP=m"
	einfo "CONFIG_PPP_ASYNC=m"
	einfo "CONFIG_PPP_DEFLATE=m"
	einfo "CONFIG_PPPOE=m"
	einfo "Otherwise quit this ebuild, rebuild your kernel and reboot"

	# show an nice warning message about zaptel not supporting devfs on 2.6
	if [ $(echo $KV | cut -d. -f1) -eq 2 ] && [ $(echo $KV|cut -d. -f2) -eq 6 ]; then
		echo
		einfo "You're using zaptel with linux-2.6:"
		ewarn "   Zaptel doesn't support devfs with 2.6, you'll need to use udev or disable devfs"
		ewarn "   or use devfs and write a script which re-creates the device nodes for you"
		ewarn ""
		ewarn "There's an experimental patch which adds devfs support when using linux-2.6, but:"
		ewarn "  1. It's an ugly hack atm and needs a cleanup..."
		ewarn "  2. I was only abled to test loding / unloading with the ztd-eth driver..."
		ewarn "  3. I _really_ don't know if it works with real hardware..."
		eerror "  4. And more important: This is not officially supported by Digium / the Asterisk project!!!"
		ewarn ""
		ewarn "If you're still interested, abort now (ctrl+c) and enable the devfs26 USE-flag"
		einfo "Feedback and bug-reports should go to: stkn@gentoo.org"
		ewarn "You have been warned!"
		echo
		einfo "Sleeping 20 Seconds..."
		epause 20
	else
		echo
		einfo "Sleeping 10 Seconds..."
		epause 10
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# >= 0.9.1 requires new patch
	epatch ${FILESDIR}/${P}-modulesd.diff

	# skbuff fix for >=linux-2.6.9
	epatch ${FILESDIR}/${P}-skbuff.diff

	# remove all from install target
	sed -i -e "s#^\(install:\)[ \t]\+all[ \t]\+\(.*\)#\1 \2#" Makefile

	# enable ztdummy...
	sed -i -e "s:#\( ztdummy.*\):\1:" Makefile

	# devfs support
	if use devfs26; then
		einfo "Enabling experimental devfs support for linux-2.6..."
		epatch ${FILESDIR}/${PN}-1.0.0-experimental-devfs26.diff
	fi
}

src_compile() {
	set_arch_to_kernel
	make || die
	set_arch_to_portage
}

src_install() {
	make INSTALL_PREFIX=${D} install || die

	dodoc ChangeLog README README.udev README.Linux26 README.fxsusb zaptel.init zaptel.sysconfig
	dodoc zaptel.conf.sample

	# additional tools
	dobin ztmonitor ztspeed zttest

	# install init script
	exeinto /etc/init.d
	newexe ${FILESDIR}/zaptel.rc6 zaptel
	insinto /etc/conf.d
	newins ${FILESDIR}/zaptel.confd zaptel
}

pkg_postinst() {
	if use devfs26; then
		ewarn "*** Warning! ***"
		ewarn "Devfs support for linux-2.6 is experimental and not"
		ewarn "supported by digium or the asterisk project!"
		echo
		ewarn "Send bug-reports to: stkn@gentoo.org"
	fi
}
