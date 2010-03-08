# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngtools/pngtools-0.4.ebuild,v 1.6 2010/03/08 22:43:31 ssuominen Exp $

EAPI=2
inherit autotools eutils

MY_PV=${PV/./_}

DESCRIPTION="A series of tools for the PNG image format"
HOMEPAGE="http://www.stillhq.com/pngtools/"
SRC_URI="http://www.stillhq.com/pngtools/source/pngtools_${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libpng-1.2.40"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.3-implicit-declarations.patch \
		"${FILESDIR}"/${P}-libpng14.patch

	eautoreconf
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die
	dodoc ABOUT AUTHORS ChangeLog NEWS README chunks.txt
	insinto /usr/share/doc/${PF}/examples
	doins *.png
}
