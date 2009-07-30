# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/amos/amos-2.0.8.ebuild,v 1.3 2009/07/30 16:49:34 ssuominen Exp $

EAPI=2
inherit eutils qt3

DESCRIPTION="A Modular, Open-Source whole genome assembler"
HOMEPAGE="http://amos.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

DEPEND=">=x11-libs/qt-3.3:3"
RDEPEND="${DEPEND}
	dev-perl/DBI
	sci-biology/mummer"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
