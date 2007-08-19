# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/smpeg/smpeg-0.4.4-r9.ebuild,v 1.2 2007/08/19 01:01:19 angelos Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit eutils toolchain-funcs autotools

DESCRIPTION="SDL MPEG Player Library"
HOMEPAGE="http://www.lokigames.com/development/smpeg.php3"
SRC_URI="ftp://ftp.lokigames.com/pub/open-source/smpeg/${P}.tar.gz
	mirror://gentoo/${P}-gtkm4.patch.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="X debug mmx opengl"

DEPEND=">=media-libs/libsdl-1.2.0
	opengl? (
		virtual/opengl
		virtual/glu )
	X? (
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libX11
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch \
		"${FILESDIR}"/${P}-gnu-stack.patch \
		"${FILESDIR}"/${P}-config.patch \
		"${FILESDIR}"/${P}-PIC.patch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-flags.patch \
		"${FILESDIR}"/${P}-automake.patch \
		"${FILESDIR}"/${P}-mmx.patch \
		"${FILESDIR}"/${P}-malloc.patch \
		"${FILESDIR}"/${P}-missing-init.patch

	cd "${WORKDIR}"
	epatch "${DISTDIR}"/${P}-gtkm4.patch.bz2
	rm "${S}/acinclude.m4"

	cd "${S}"
	AT_M4DIR="${S}/m4" eautoreconf
}

src_compile() {
	tc-export CC CXX RANLIB AR

	# the debug option is bogus ... all it does is add extra
	# optimizations if you pass --disable-debug
	econf \
		--enable-debug \
		--disable-gtk-player \
		$(use_enable debug assertions) \
		$(use_with X x) \
		$(use_enable opengl opengl-player) \
		$(use_enable mmx) \
		|| die

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES README* TODO
}
