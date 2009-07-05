# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/mergelog/mergelog-4.5-r1.ebuild,v 1.3 2009/07/05 20:05:12 hollow Exp $

inherit autotools eutils

DESCRIPTION="A utility to merge apache logs in chronological order"
SRC_URI="mirror://sourceforge/mergelog/${P}.tar.gz"
HOMEPAGE="http://mergelog.sourceforge.net"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-splitlog.patch
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_compile() {
	econf || die "configure failed"
	emake  || die "make failed"
}

src_install() {
	einstall
	dobin src/mergelog src/zmergelog

	doman man/*.1
	dodoc AUTHORS README
}
