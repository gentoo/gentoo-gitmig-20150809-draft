# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zaptel/zaptel-0.8.1.ebuild,v 1.2 2004/03/17 20:45:57 stkn Exp $

IUSE=""

DESCRIPTION="Pseudo-TDM engine"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/zaptel/old/zaptel-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	virtual/linux-sources"

pkg_setup() {
	# check if we're running a 2.6 kernel (not supported, atm)
	if [ $(echo $KV | cut -d. -f1) -eq 2 ] && [ $(echo $KV|cut -d. -f2) -eq 6 ]; then
		eerror "Linux kernel 2.6 is not supported at the moment..."
		die
	fi

	einfo "Please make sure that your kernel has the appropriate"
	einfo "ppp support enabled or present as modules before merging"
	einfo "e.g."
	einfo "CONFIG_PPP=m"
	einfo "CONFIG_PPP_ASYNC=m"
	einfo "CONFIG_PPP_DEFLATE=m"
	einfo "CONFIG_PPPOE=m"
	einfo "Otherwise quit this ebuild, rebuild your kernel and reboot"
	sleep 5
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-mkdir-usrincludelinux.patch
	epatch ${FILESDIR}/${PN}-modulesd.patch
}

src_compile() {
	make || die
}

src_install() {
	make INSTALL_PREFIX=${D} install || die

	dodoc ChangeLog README.fxsusb zaptel.init zaptel.sysconfig
	dodoc zaptel.conf.sample
}
