# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/wvstreams/wvstreams-4.0.1-r2.ebuild,v 1.8 2005/04/06 18:54:40 blubb Exp $

inherit eutils

DESCRIPTION="A network programming library in C++"
HOMEPAGE="http://open.nit.ca/wiki/?page=WvStreams"
SRC_URI="http://people.nit.ca/~sfllaw/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ppc sparc x86"
IUSE="gtk qt oggvorbis speex fam qdbm pam slp doc fftw tcltk debug"

RDEPEND="virtual/libc
	dev-libs/xplc
	gtk? ( >=x11-libs/gtk+-2.2.0 )
	qt? ( =x11-libs/qt-3* )
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
	fftw? ( sci-libs/fftw )
	tcltk? ( >=dev-lang/tcl-8.4* dev-lang/swig )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/autoconf-2.59"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-linux-serial.patch
	epatch ${FILESDIR}/${P}-wireless-user.patch
	epatch ${FILESDIR}/${P}-without-pam.patch

	if useq tcltk; then
		epatch ${FILESDIR}/${P}-tcl_8_4.patch
		env WANT_AUTOCONF=2.59 autoconf || die "autoconf failed"
	fi

	useq qt && epatch ${FILESDIR}/${P}-MOC-fix.patch
}

src_compile() {
	local myconf
	if useq qt; then
		myconf="--with-qt=/usr/qt/3/"
		export MOC="/usr/qt/3/bin/moc"
	else
		myconf="--without-qt"
	fi
	econf ${myconf} \
		`use_with gtk` \
		`use_with oggvorbis ogg` \
		`use_with oggvorbis vorbis` \
		`use_with speex` \
		`use_with fam` \
		`use_with qdbm` \
		`use_with pam` \
		`use_with fftw` \
		`use_with slp openslp` \
		`use_with tcltk tcl` \
		`use_enable debug` \
		--enable-verbose \
		--with-bdb \
		--with-openssl \
		--with-zlib \
		--with-xplc \
		|| die "configure failed"
	emake CXXOPTS="-fPIC -DPIC" COPTS="-fPIC -DPIC" || die "compile failed"
	use doc && doxygen
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README COPYING.LIB
	use doc && dohtml -r Docs/doxy-html/*
}
