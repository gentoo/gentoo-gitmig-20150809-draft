# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/amos/amos-2.0.8.ebuild,v 1.2 2009/03/15 17:58:50 maekke Exp $

EAPI="1"
inherit qt3 eutils

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

src_compile() {
	econf || die "econf failed"
	# TODO: fix parallel make. Notified upstream
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
