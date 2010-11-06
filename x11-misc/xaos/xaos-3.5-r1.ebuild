# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xaos/xaos-3.5-r1.ebuild,v 1.1 2010/11/06 15:03:30 jlec Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="A very fast real-time fractal zoomer"
HOMEPAGE="http://xaos.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="aalib doc -gtk nls png svga threads X"

RDEPEND="sys-libs/zlib
	sci-libs/gsl
	aalib? ( media-libs/aalib )
	gtk? ( >=x11-libs/gtk+-2 )
	png? ( media-libs/libpng )
	X? ( x11-libs/libX11
		 x11-libs/libXxf86dga
		 x11-libs/libXext
		 x11-libs/libXxf86vm )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( virtual/latex-base
		dev-texlive/texlive-texinfo )
	X? ( x11-proto/xf86vidmodeproto
		 x11-proto/xextproto
		 x11-proto/xf86dgaproto
		 x11-proto/xproto )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.4-png.patch
	epatch "${FILESDIR}"/${PN}-3.4-include.patch
	sed -i -e 's/-s//' Makefile.in
	eautoreconf
}

src_configure() {
	# use gsl and not nasm (see bug #233318)
	econf \
		--with-sffe=yes \
		--with-gsl=yes \
		$(use_enable nls) \
		$(use_with png) \
		$(use_with aalib aa-driver) \
		$(use_with gtk gtk-driver) \
		$(use_with threads pthread) \
		$(use_with X x11-driver) \
		$(use_with X x)
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		cd "${S}"/doc
		emake xaos.dvi || die
		dvipdf xaos.dvi || die
		cd "${S}"/help
		emake html || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog* NEWS README AUTHORS
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/xaos.pdf || die
		dohtml -r help/* || die
	fi
	local driver="x11"
	use gtk && driver="\"GTK+ Driver\""
	make_desktop_entry "xaos -driver ${driver}" "XaoS Fractal Zoomer" \
		xaos "Application;Education;Math;Graphics;"
	doicon "${FILESDIR}"/${PN}.png || die
}
