# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arj/arj-3.10g.ebuild,v 1.10 2004/11/15 13:19:28 gustavoz Exp $

inherit eutils

DESCRIPTION="Utility for opening arj archives"
HOMEPAGE="http://arj.sourceforge.net/"
SRC_URI="mirror://sourceforge/arj/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""
RESTRICT="nostrip"

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	epatch ${FILESDIR}/arj-3.10.18-2.6.headers.patch
	cd gnu
	autoconf
	econf || die
	cd ../
	make prepare || die "make prepare failed"
	make package || die "make package failed"
}

src_install() {
	cd ${S}/linux-gnu/en/rs/u
	dobin bin/* || die
	dodoc doc/arj/* ${S}/ChangeLog
}
