# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/wvstreams/wvstreams-4.0-r1.ebuild,v 1.1 2004/12/08 17:15:45 mrness Exp $

inherit eutils

DESCRIPTION="A network programming library in C++"
HOMEPAGE="http://open.nit.ca/wiki/?page=WvStreams"
SRC_URI="http://people.nit.ca/~sfllaw/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~amd64 ~hppa ~ppc"
IUSE="gtk qt oggvorbis speex fam qdbm pam slp doc fftw tcltk"

RDEPEND="virtual/libc
	dev-libs/xplc
	gtk? ( >=x11-libs/gtk+-2.2.0 )
	qt? ( >=x11-libs/qt-3.0.5 )
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )
	speex? ( media-libs/speex !=media-libs/speex-1.1.4 )
	fam? ( virtual/fam )
	>=sys-libs/db-3
	qdbm? ( dev-db/qdbm )
	pam? ( >=sys-libs/pam-0.75 )
	slp? ( >=net-libs/openslp-1.0.9a )
	>=sys-libs/zlib-1.1.4
	dev-libs/openssl
	doc? ( app-doc/doxygen )
	fftw? ( dev-libs/fftw )
	tcltk? ( >=dev-lang/tcl-8.4* dev-lang/swig )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/autoconf-2.59"

src_unpack() {
	unpack ${A} ; cd ${S}

	if useq tcltk; then
		epatch ${FILESDIR}/${P}-tcl_8_4.patch
		env WANT_AUTOCONF=2.59 autoconf || die "autoconf failed"
	fi
}

src_compile() {
	econf `use_with gtk` \
		`use_with qt` \
		`use_with oggvorbis ogg` \
		`use_with oggvorbis vorbis` \
		`use_with speex` \
		`use_with fam` \
		`use_with qdbm` \
		`use_with pam` \
		`use_with fftw` \
		`use_with slp openslp` \
		`use_with tcltk tcl` \
		--enable-verbose \
		--with-bdb \
		--with-openssl \
		--with-zlib \
		|| die "configure failed"
	emake CXXOPTS="-fPIC -DPIC" COPTS="-fPIC -DPIC" || die "compile failed"
	use doc && doxygen
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README COPYING.LIB
	use doc && dohtml -r Docs/doxy-html/*
}
