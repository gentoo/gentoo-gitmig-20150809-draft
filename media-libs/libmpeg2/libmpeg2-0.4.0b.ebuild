# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg2/libmpeg2-0.4.0b.ebuild,v 1.18 2005/03/21 06:58:07 mr_bones_ Exp $

inherit eutils flag-o-matic

MY_P="${P/libmpeg2/mpeg2dec}"
DESCRIPTION="library for decoding mpeg-2 and mpeg-1 video"
HOMEPAGE="http://libmpeg2.sourceforge.net/"
SRC_URI="http://libmpeg2.sourceforge.net/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc sparc x86"
IUSE="sdl X"

DEPEND="virtual/libc
	sdl? ( media-libs/libsdl )
	X? ( virtual/x11 )"

S="${WORKDIR}/${MY_P/b/}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	use alpha && append-flags -fPIC

	# Resolves bug 73224.
	# <slarti@gentoo.org> Dec 2004
	use amd64 && append-flags -fPIC

	# Fix a compilation-error with gcc 3.4. Bug #51964.
	epatch "${FILESDIR}/gcc34-inline-fix-${PV}.diff"
	epatch "${FILESDIR}/altivec-fix-${PV}.diff"
	# get rid of the -mcpu
	sed -i \
		-e '/-mcpu/d' \
		configure.in \
		|| die "sed configure failed"
	aclocal && automake && libtoolize --copy --force && autoconf \
		|| die "autotools failed"
}

src_compile() {
	# x86 asm + 64bit binary == no worky (fixes bug 69227)
	use amd64 && myconf="--disable-accel-detect"

	econf \
		--enable-shared \
		--disable-dependency-tracking \
		$(use_enable sdl) \
		$(use_with X x) \
		${myconf} \
		|| die
	# builds non-pic library by default? (bug #44934)
	emake LIBMPEG2_CFLAGS= || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
