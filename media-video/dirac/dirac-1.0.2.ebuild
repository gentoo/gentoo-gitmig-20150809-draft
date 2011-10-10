# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dirac/dirac-1.0.2.ebuild,v 1.10 2011/10/10 21:01:10 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Open Source video codec"
HOMEPAGE="http://dirac.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug doc mmx static-libs"

RDEPEND=""
DEPEND="
	doc? (
		app-doc/doxygen
		virtual/latex-base
		media-gfx/graphviz
		app-text/dvipdfm
	)"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.5.2-doc.patch
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	export VARTEXFONTS="${T}/fonts"

	econf \
		$(use_enable static-libs static) \
		$(use_enable mmx) \
		$(use_enable debug) \
		$(use_enable doc)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		htmldir=/usr/share/doc/${PF}/html \
		latexdir=/usr/share/doc/${PF}/programmers \
		algodir=/usr/share/doc/${PF}/algorithm \
		faqdir=/usr/share/doc/${PF} \
		install

	dodoc AUTHORS ChangeLog NEWS README TODO

	find "${ED}"usr -name '*.la' -exec rm -f {} +
}
