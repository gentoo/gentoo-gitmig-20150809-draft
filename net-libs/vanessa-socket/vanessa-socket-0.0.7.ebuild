# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/vanessa-socket/vanessa-socket-0.0.7.ebuild,v 1.5 2005/01/21 20:41:27 xmerlin Exp $

inherit eutils

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Simplifies TCP/IP socket operations."
HOMEPAGE="http://www.vergenet.net/linux/vanessa/"
SRC_URI="http://www.vergenet.net/linux/vanessa/download/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/vanessa-logger-0.0.6"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/vanessa-socket-0.0.7-version.patch || die
}

src_compile() {
	econf || die "error configure"
	emake || die "error compiling"
}

src_install() {
	make DESTDIR=${D} install || die "error installing"
	dodoc README NEWS AUTHORS TODO
}
