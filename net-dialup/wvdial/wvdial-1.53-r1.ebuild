# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/wvdial/wvdial-1.53-r1.ebuild,v 1.7 2003/09/12 13:59:18 seemant Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Excellent program which automatically configures your PPP session"
SRC_URI="http://open.nit.ca/download/${P}.tar.gz"
HOMEPAGE="http://open.nit.ca/"

DEPEND=">=sys-apps/sed-4
	net-libs/wvstreams"

RDEPEND="${DEPEND}
	net-dialup/ppp"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc amd64 hppa alpha"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-crypt.patch

}

src_compile() {

	sed -i "s:PREFIX=/usr/local:PREFIX=/usr:" Makefile
}

src_install() {
	sed -i "s:PPPDIR=/etc/ppp/peers:PPPDIR=${D}/etc/ppp/peers:" Makefile

	make \
		PREFIX=${D}/usr \
		install || die

	dodoc ANNOUNCE CHANGES COPYING.LIB README
	dodoc debian/copyright debian/changelog
}

pkg_postinst() {

	einfo
	einfo "Use wvdialconf to automagically generate a configuration-file."
	einfo 
	einfo "Users have to be member of the dialout AND the uucp group"
	einfo "to use wvdial!"
	einfo
}

