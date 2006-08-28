# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/epix/epix-1.0.7.ebuild,v 1.3 2006/08/28 16:55:38 wolf31o2 Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="2- and 3-D plotter for creating images (to be used in LaTeX)"
HOMEPAGE="http://mathcs.holycross.edu/~ahwang/current/ePiX.html"
SRC_URI="http://mathcs.holycross.edu/~ahwang/epix/${P}_complete.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/tetex"

RDEPEND="app-shells/bash
		>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-doc-gentoo.patch
	sed -e "s:/doc/${PN}:/doc/${P}:" -i Makefile.in doc/Makefile.in \
		samples/Makefile.in
}

src_compile() {
	econf || die "failed to configure"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
