# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsaplayer/alsaplayer-0.99.76-r3.ebuild,v 1.4 2006/04/28 19:22:00 josejx Exp $

inherit eutils

DESCRIPTION="Media player primarily utilising ALSA"
HOMEPAGE="http://www.alsaplayer.org/"
SRC_URI="http://www.alsaplayer.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ~mips ppc ~sparc x86"
IUSE="alsa audiofile doc esd flac jack mikmod nas nls ogg opengl oss vorbis xosd"

RDEPEND=">=dev-libs/glib-1.2.10
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	audiofile? ( media-libs/audiofile )
	esd? ( media-sound/esound )
	flac? ( media-libs/flac )
	jack? ( >=media-sound/jack-audio-connection-kit-0.80.0 )
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	nas? ( media-libs/nas )
	ogg? ( media-libs/libogg )
	opengl? ( virtual/opengl )
	vorbis? ( media-libs/libvorbis )
	xosd? ( x11-libs/xosd )"

DEPEND="${RDEPEND}
	sys-apps/sed
	doc? ( app-doc/doxygen )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if use ppc; then
		epatch ${FILESDIR}/alsaplayer-endian.patch
	fi

	epatch "${FILESDIR}/${P}-join-null-thread.patch"
}

src_compile() {
	export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include"

	use xosd ||
		export ac_cv_lib_xosd_xosd_create="no"

	use doc ||
		export ac_cv_prog_HAVE_DOXYGEN="false"

	if use ogg && use flac; then
		myconf="${myconf} --enable-oggflac"
	fi

	econf \
		$(use_enable audiofile) \
		$(use_enable esd) \
		$(use_enable flac) \
		$(use_enable jack) \
		$(use_enable mikmod) \
		$(use_enable nas) \
		$(use_enable opengl) \
		$(use_enable oss) \
		$(use_enable nls) \
		$(use_enable sparc) \
		$(use_enable vorbis oggvorbis) \
		${myconf} \
		--disable-gtk \
		--disable-sgi --disable-dependency-tracking

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} docdir=${D}/usr/share/doc/${PF} install \
		|| die "make install failed"

	dodoc AUTHORS ChangeLog README TODO
	dodoc docs/wishlist.txt
}
