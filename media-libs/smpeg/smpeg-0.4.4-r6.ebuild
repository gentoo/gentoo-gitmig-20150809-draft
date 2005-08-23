# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/smpeg/smpeg-0.4.4-r6.ebuild,v 1.1 2005/08/23 03:10:35 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="SDL MPEG Player Library"
HOMEPAGE="http://www.lokigames.com/development/smpeg.php3"
SRC_URI="ftp://ftp.lokigames.com/pub/open-source/smpeg/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="X gtk opengl debug"

DEPEND=">=media-libs/libsdl-1.2.0
	opengl? ( virtual/opengl virtual/glu )
	gtk? ( =x11-libs/gtk+-1.2* )
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	epatch "${FILESDIR}"/${P}-gnu-stack.patch
	epatch "${FILESDIR}"/${P}-config.patch
	sed -i \
		-e 's:-mcpu=ev4 -Wa,-mall::' \
		-e 's:-march=486::' \
		-e 's:-march=pentium -mcpu=pentiumpro::' \
		configure || die "sed configure failed"
	# Bundled libtool doesnt properly add C++ libs even
	# though the shared library includes C++ objects
	sed -i \
		-e '/^libsmpeg_la_LIBADD =/s:$: -lstdc++:' \
		Makefile.in || die "sed Makefile.in failed"
}

src_compile() {
	# --enable-mmx causes test apps to crash on startup #470
	#	$(use_enable mmx) \
	econf \
		$(use_enable debug) \
		$(use_enable debug assertions) \
		$(use_enable gtk gtk-player) \
		$(use_with X x) \
		$(use_enable opengl opengl-player) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES README* TODO
}
