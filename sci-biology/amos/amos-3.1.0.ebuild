# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/amos/amos-3.1.0.ebuild,v 1.1 2011/08/12 15:48:21 weaver Exp $

EAPI=4

inherit eutils

DESCRIPTION="A Modular, Open-Source whole genome assembler"
HOMEPAGE="http://amos.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE="qt"
KEYWORDS="~amd64 ~x86"

DEPEND="qt? ( x11-libs/qt-core:4 )"
RDEPEND="${DEPEND}
	dev-perl/DBI
	dev-perl/Statistics-Descriptive
	sci-biology/mummer"

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
