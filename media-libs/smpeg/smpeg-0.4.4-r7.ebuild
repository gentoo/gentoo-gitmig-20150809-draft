# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/smpeg/smpeg-0.4.4-r7.ebuild,v 1.12 2006/04/24 02:39:18 kumba Exp $

inherit eutils toolchain-funcs

DESCRIPTION="SDL MPEG Player Library"
HOMEPAGE="http://www.lokigames.com/development/smpeg.php3"
SRC_URI="ftp://ftp.lokigames.com/pub/open-source/smpeg/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 mips ppc ppc-macos ppc64 sh sparc x86"
IUSE="X debug gtk mmx opengl"

DEPEND=">=media-libs/libsdl-1.2.0
	opengl? (
		virtual/opengl
		virtual/glu )
	gtk? ( =x11-libs/gtk+-1.2* )
	X? ( || (
		(
			x11-libs/libXext
			x11-libs/libXi
			x11-libs/libX11 )
		virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	epatch "${FILESDIR}"/${P}-gnu-stack.patch
	epatch "${FILESDIR}"/${P}-config.patch
	epatch "${FILESDIR}"/${P}-PIC.patch
	epatch "${FILESDIR}"/${P}-gcc41.patch
	# Bundled libtool doesnt properly add C++ libs even
	# though the shared library includes C++ objects
	sed -i \
		-e '/^libsmpeg_la_LIBADD =/s:$: -lstdc++:' \
		Makefile.in || die "sed Makefile.in failed"
}

src_compile() {
	tc-export CC CXX RANLIB AR

	# the debug option is bogus ... all it does is add extra
	# optimizations if you pass --disable-debug
	econf \
		$(use_enable debug assertions) \
		$(use_enable gtk gtk-player) \
		$(use_with X x) \
		$(use_enable opengl opengl-player) \
		$(use_enable mmx) \
		--enable-debug \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES README* TODO
}
