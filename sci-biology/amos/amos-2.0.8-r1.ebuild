# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/amos/amos-2.0.8-r1.ebuild,v 1.1 2010/02/11 16:47:31 weaver Exp $

EAPI="2"

# qt3 is scheduled for removal, so don't depend on it - package compiles fine either way
#inherit eutils qt3
inherit eutils

DESCRIPTION="A Modular, Open-Source whole genome assembler"
HOMEPAGE="http://amos.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

#DEPEND=">=x11-libs/qt-3.3:3"
DEPEND=""
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
