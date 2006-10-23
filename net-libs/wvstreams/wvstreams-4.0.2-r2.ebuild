# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/wvstreams/wvstreams-4.0.2-r2.ebuild,v 1.9 2006/10/23 07:46:37 mrness Exp $

inherit eutils

DESCRIPTION="A network programming library in C++"
HOMEPAGE="http://open.nit.ca/wiki/?page=WvStreams"
SRC_URI="http://www.csclub.uwaterloo.ca/~ja2morri/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ppc sparc x86"
IUSE="gtk qt3 vorbis speex fam qdbm pam slp doc fftw tcl debug"

RDEPEND="virtual/libc
	>=sys-libs/db-3
	>=sys-libs/zlib-1.1.4
	>=dev-libs/openssl-0.9.7
	dev-libs/xplc
	gtk? ( >=x11-libs/gtk+-2.2.0 )
	qt3? ( =x11-libs/qt-3* )
	vorbis? ( >=media-libs/libvorbis-1.0 )
	speex? ( media-libs/speex !=media-libs/speex-1.1.4 )
	fam? ( virtual/fam )
	qdbm? ( dev-db/qdbm )
	pam? ( >=sys-libs/pam-0.75 )
	slp? ( >=net-libs/openslp-1.0.9a )
	doc? ( app-doc/doxygen )
	fftw? ( sci-libs/fftw )
	tcl? ( >=dev-lang/tcl-8.4 dev-lang/swig )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/autoconf-2.59"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-gcc41.patch
	epatch ${FILESDIR}/${P}-linux-serial.patch
	epatch ${FILESDIR}/${P}-wireless-user.patch
	epatch ${FILESDIR}/${P}-speex-const.patch

	if useq tcl; then
		epatch ${FILESDIR}/${P}-tcl_8_4.patch
	fi

	epatch ${FILESDIR}/${P}-external-xplc.patch
	local XPLC_VER=$(best_version dev-libs/xplc)
	XPLC_VER=${XPLC_VER#*/*-} #reduce it to ${PV}-${PR}
	XPLC_VER=${XPLC_VER%%[_-]*} # main version without beta/pre/patch/revision
	sed -i -e "s:^xplc_version=.*:xplc_version='${XPLC_VER}':" "${S}/configure.ac" \
		|| die "failed to set current xplc version"

	useq qt3 && epatch ${FILESDIR}/${P}-MOC-fix.patch
}

src_compile() {
	env WANT_AUTOCONF=2.5 autoconf || die "autoconf failed" #needed by xplc and tcl patch

	local myconf
	if useq qt3; then
		myconf="--with-qt=/usr/qt/3/"
		export MOC="/usr/qt/3/bin/moc"
	else
		myconf="--without-qt"
	fi
	econf ${myconf} \
		$(use_with gtk) \
		$(use_with vorbis ogg) \
		$(use_with vorbis) \
		$(use_with speex) \
		$(use_with fam) \
		$(use_with qdbm) \
		$(use_with pam) \
		$(use_with fftw) \
		$(use_with slp openslp) \
		$(use_with tcl) \
		$(use_enable debug) \
		--enable-verbose \
		--with-bdb \
		--with-zlib \
		--with-openssl \
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
