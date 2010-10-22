# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdfsandwich/pdfsandwich-0.0.2.ebuild,v 1.2 2010/10/22 18:30:00 tomka Exp $

EAPI="2"

DESCRIPTION="generator of sandwich OCR pdf files"
HOMEPAGE="http://pdfsandwich.origo.ethz.ch/wiki/pdfsandwich"
SRC_URI="http://download.origo.ethz.ch/pdfsandwich/1809/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

# >=cuneiform-0.9 will break placement of background text with
# exact-image  This is discussed on upstream's mailing list.

RDEPEND="<app-text/cuneiform-0.9.0[imagemagick]
	media-gfx/exact-image
	app-text/ghostscript-gpl"
DEPEND="sys-apps/gawk
	>=dev-lang/ocaml-3.08[ocamlopt]"

src_prepare() {
	sed -i "/^OCAMLOPTFLAGS/s/$/ -ccopt \"\$(CFLAGS) \$(LDFLAGS)\"/" Makefile || die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
