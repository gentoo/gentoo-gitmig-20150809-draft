# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg2/libmpeg2-0.4.0b.ebuild,v 1.15 2004/12/03 17:21:21 slarti Exp $

inherit eutils libtool flag-o-matic

MY_P="${P/libmpeg2/mpeg2dec}"
S="${WORKDIR}/${MY_P/b/}"
DESCRIPTION="library for decoding mpeg-2 and mpeg-1 video"
SRC_URI="http://libmpeg2.sourceforge.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://libmpeg2.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64 sparc"
IUSE="sdl X"

RDEPEND="virtual/libc
	sdl? ( media-libs/libsdl )
	X? ( virtual/x11 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	use alpha && append-flags -fPIC

	# Resolves bug 73224.
	# <slarti@gentoo.org> Dec 2004
	use amd64 && append-flags -fPIC

	unpack ${A}

	# get rid of the -mcpu
	cd ${S}
	sed -i \
		-e 's:OPT_CFLAGS=\"$CFLAGS -mcpu=.*\":OPT_CFLAGS=\"$CFLAGS\":g' \
			configure || die "sed configure failed"

	# Fix a compilation-error with gcc 3.4. Bug #51964.
	( cd "${S}" && epatch "${FILESDIR}/gcc34-inline-fix-${PV}.diff" )

	epatch "${FILESDIR}/altivec-fix-${PV}.diff"
	autoreconf
}

src_compile() {
	elibtoolize

	# x86 asm + 64bit binary == no worky (fixes bug 69227)
	use amd64 && myconf="--disable-accel-detect"

	econf \
		--enable-shared \
		--disable-dependency-tracking \
		`use_enable sdl` \
		`use_with X x` \
		${myconf} \
			|| die
	# builds non-pic library by default? (bug #44934)
	emake LIBMPEG2_CFLAGS= || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
