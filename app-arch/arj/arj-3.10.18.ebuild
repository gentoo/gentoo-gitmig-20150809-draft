# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arj/arj-3.10.18.ebuild,v 1.8 2004/10/05 10:59:23 pvdabeel Exp $

inherit gnuconfig eutils

DESCRIPTION="Utility for opening arj archives"
HOMEPAGE="http://arj.sourceforge.net/"
SRC_URI="mirror://sourceforge/arj/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc amd64"
IUSE=""
RESTRICT="nostrip"

DEPEND="virtual/libc"


S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${P}-fPIC.patch
	epatch ${FILESDIR}/${P}-2.6.headers.patch
}

src_compile() {
	gnuconfig_update

	cd ${S}/gnu
	autoconf
	econf || die

	cd ${S}
	make prepare || die "make prepare failed"
	make package || die "make package failed"
}

src_install() {
	cd ${S}/linux-gnu/en/rs/u
	dobin bin/* || die
	dodoc doc/arj/* ${S}/ChangeLog
}
