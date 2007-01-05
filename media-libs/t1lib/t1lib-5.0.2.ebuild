# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/t1lib/t1lib-5.0.2.ebuild,v 1.28 2007/01/05 08:35:17 flameeyes Exp $

inherit eutils flag-o-matic libtool toolchain-funcs

DESCRIPTION="A Type 1 Font Rasterizer Library for UNIX/X11"
HOMEPAGE="ftp://metalab.unc.edu/pub/Linux/libs/graphics/"
SRC_URI="ftp://sunsite.unc.edu/pub/Linux/libs/graphics/${P}.tar.gz"

LICENSE="LGPL-2 GPL-2"
SLOT="5"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="X doc"

RDEPEND="X? ( x11-libs/libXaw )"

DEPEND="${RDEPEND}
	doc? ( virtual/tetex )
	X? ( || ( (
		x11-libs/libXfont
		x11-proto/xproto
		x11-proto/fontsproto )
	virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	use ppc-macos && darwintoolize
	cd ${S}
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}-asneeded.patch"

	sed -i -e "s:dvips:#dvips:" ${S}/doc/Makefile.in

	sed -i -e "s:\./\(t1lib\.config\):/etc/t1lib/\1:" ${S}/xglyph/xglyph.c
}

src_compile() {
	local myopt=""

	tc-export CC

	use alpha && append-flags -mieee

	if ! use doc; then
		myopt="without_doc"
	else
		addwrite /var/cache/fonts
	fi

	econf \
		--datadir=/etc \
		`use_with X x` \
		 || die
	emake ${myopt} || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc Changes LGPL LICENSE README*
	if use doc ; then
		cd doc
		insinto /usr/share/doc/${PF}
		doins *.pdf *.dvi
	fi
}

pkg_postinst() {
	ewarn
	ewarn "You must rebuild other packages depending on t1lib."
	ewarn "You may use revdep-rebuild (from app-portage/gentoolkit)"
	ewarn "to do all necessary tricks."
	ewarn
}
