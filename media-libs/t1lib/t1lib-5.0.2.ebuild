# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/t1lib/t1lib-5.0.2.ebuild,v 1.11 2004/10/24 23:34:11 lanius Exp $

inherit eutils gnuconfig flag-o-matic libtool

DESCRIPTION="A Type 1 Font Rasterizer Library for UNIX/X11"
HOMEPAGE="ftp://metalab.unc.edu/pub/Linux/libs/graphics/"
SRC_URI="ftp://sunsite.unc.edu/pub/Linux/libs/graphics/${P}.tar.gz"

LICENSE="LGPL-2 GPL-2"
SLOT="5"
KEYWORDS="x86 ~ppc ~sparc ~alpha arm ~hppa ~amd64 ~ia64 s390 ppc64 ppc-macos"
IUSE="X doc"

DEPEND="X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	if use amd64 || use alpha || use ppc64 || use ppc-macos; then
		gnuconfig_update || die "gnuconfig_update failed"
	fi
	use ppc-macos && darwintoolize
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff

	cd ${S}/doc
	mv Makefile.in Makefile.in-orig
	sed -e "s:dvips:#dvips:" Makefile.in-orig>Makefile.in

	sed -i -e "s:\./\(t1lib\.config\):/etc/t1lib/\1:" ${S}/xglyph/xglyph.c
}

src_compile() {
	local myopt=""

	use alpha && append-flags -mieee

	if [ ! -x /usr/bin/latex ] ; then
		myopt="without_doc"
	else
		addwrite /var/cache/fonts
	fi

	econf \
		--datadir=/etc \
		`use_with X x` \
		 || die
	make ${myopt} || die
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
