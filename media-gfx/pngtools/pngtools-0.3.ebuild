# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngtools/pngtools-0.3.ebuild,v 1.4 2008/04/23 18:53:07 drac Exp $

inherit eutils toolchain-funcs

MY_PV=${PV/./_}

DESCRIPTION="A series of tools for the PNG image format"
HOMEPAGE="http://www.stillhq.com/pngtools"
SRC_URI="http://www.stillhq.com/pngtools/source/pngtools_${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/libpng-1.2.8-r1
		virtual/libc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-implicit-declarations.patch
}

src_compile() {
	tc-export CC
	econf
	emake || die "emake failed."
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die "emake install failed."
	dodoc ABOUT AUTHORS ChangeLog NEWS README chunks.txt
	insinto /usr/share/doc/${PF}/examples
	doins *.png
}
