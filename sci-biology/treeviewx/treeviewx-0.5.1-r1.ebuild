# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/treeviewx/treeviewx-0.5.1-r1.ebuild,v 1.3 2010/02/18 02:55:23 dirtyepic Exp $

inherit eutils wxwidgets

DESCRIPTION="A phylogenetic tree viewer"
HOMEPAGE="http://darwin.zoology.gla.ac.uk/~rpage/treeviewx/"
SRC_URI="http://darwin.zoology.gla.ac.uk/~rpage/${PN}/download/0.5/tv-${PV}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~amd64 x86"
SLOT="0"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.6*"

S="${WORKDIR}/tv-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-wxt.patch
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
}

src_compile() {
	WX_GTK_VER="2.6"
	need-wxwidgets gtk2

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
}
