# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/wvstreams/wvstreams-4.0.ebuild,v 1.4 2004/11/22 23:38:47 gmsoft Exp $

inherit eutils

DESCRIPTION="A network programming library in C++"
HOMEPAGE="http://open.nit.ca/wiki/?page=WvStreams"
SRC_URI="http://people.nit.ca/~sfllaw/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~amd64 ~hppa ~ppc"
IUSE="gtk qt oggvorbis speex fam gdbm pam fftw tcltk"

RDEPEND="gtk? ( >=x11-libs/gtk+-2.2.0 )
	qt? ( >=x11-libs/qt-3.0.5 )
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )
	speex? ( media-libs/speex !=media-libs/speex-1.1.4 )
	fam? ( >=app-admin/fam-2.7.0 )
	>=sys-libs/db-3
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	pam? ( >=sys-libs/pam-0.75 )
	>=sys-libs/zlib-1.1.4
	dev-libs/openssl
	fftw? ( dev-libs/fftw )
	tcltk? ( dev-lang/tcl
		dev-lang/swig )"

DEPEND="${RDEPEND}
	virtual/libc
	dev-util/pkgconfig
	tcltk? ( >=dev-lang/tcl-8.4*
		>=sys-devel/autoconf-2.59 )"

src_unpack() {
	unpack ${A} ; cd ${S}

	if useq tcltk
	then
		epatch ${FILESDIR}/${P}-tcl_8_4.patch
		env WANT_AUTOCONF=2.59 autoconf || die
	fi
}

src_compile() {
	econf `use_with gtk` \
		`use_with qt` \
		`use_with oggvorbis ogg` \
		`use_with oggvorbis vorbis` \
		`use_with fam` \
		`use_with gdbm` \
		`use_with pam` \
		`use_with qt` \
		`use_with speex` \
		`use_with fftw` \
		`use_with tcltk tcl` \
		--enable-verbose \
		--with-bdb \
		--with-openssl \
		--with-zlib \
		|| die
	make CXXOPTS="-fPIC -DPIC" COPTS="-fPIC -DPIC" || die "compile failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
