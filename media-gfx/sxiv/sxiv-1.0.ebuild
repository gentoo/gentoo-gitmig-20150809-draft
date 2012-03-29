# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sxiv/sxiv-1.0.ebuild,v 1.2 2012/03/29 08:36:42 ago Exp $

EAPI=4

inherit eutils savedconfig toolchain-funcs

DESCRIPTION="Simple (or small or suckless) X Image Viewer"
HOMEPAGE="https://github.com/muennich/sxiv/"
SRC_URI="https://github.com/downloads/muennich/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="media-libs/imlib2[X]
	x11-libs/libX11"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e "s:^\(\(C\|LD\)FLAGS\) =:\1 +=:" \
		-e "s:-O2::" Makefile || die

	restore_config config.h
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}"/usr install
	dodoc README.md

	save_config config.h
}
