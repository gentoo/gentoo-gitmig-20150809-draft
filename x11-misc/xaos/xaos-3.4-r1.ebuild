# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xaos/xaos-3.4-r1.ebuild,v 1.2 2011/03/02 13:44:10 jlec Exp $

EAPI=2
inherit eutils autotools

MY_PN=XaoS
MY_P=${MY_PN}-${PV}

DESCRIPTION="A very fast real-time fractal zoomer"
HOMEPAGE="http://xaos.sf.net/"
SRC_URI="mirror://sourceforge/xaos/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="aalib doc gtk nls png svga threads X"

RDEPEND="sys-libs/zlib
	sci-libs/gsl
	aalib? ( media-libs/aalib )
	gtk? ( x11-libs/gtk+:2 )
	png? ( media-libs/libpng )
	svga? ( media-libs/svgalib )
	X? ( x11-libs/libX11
		 x11-libs/libXxf86dga
		 x11-libs/libXext
		 x11-libs/libXxf86vm )"
# xaos has ggi support, but it doesn't build
#	ggi?   ( media-libs/libggi )

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( virtual/latex-base )
	X? ( x11-proto/xf86vidmodeproto
		 x11-proto/xextproto
		 x11-proto/xf86dgaproto
		 x11-proto/xproto )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-png.patch
	epatch "${FILESDIR}"/${P}-include.patch
	epatch "${FILESDIR}"/${P}-x11.patch
	eautoreconf
}

src_configure() {
	# use gsl and not nasm (see bug #233318)
	econf \
		--with-sffe=yes \
		--with-ggi-driver=no \
		--with-i386asm=no \
		--with-gsl=yes \
		$(use_enable nls) \
		$(use_with png) \
		$(use_with aalib aa-driver) \
		$(use_with gtk gtk-driver) \
		$(use_with svga svga-driver) \
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
	dodoc ChangeLog* TODO RELEASE_NOTES \
		doc/README{,.bugs} doc/{AUTHORS,PROBLEMS,SPONSORS}
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/xaos.pdf || die
		dohtml help/* || die
	fi
	local driver="x11"
	use gtk && driver="\"GTK+ Driver\""
	make_desktop_entry "xaos -driver ${driver}" "XaoS Fractal Zoomer" \
		xaos "Application;Education;Math;Graphics;"
	doicon "${FILESDIR}"/${PN}.png
}
