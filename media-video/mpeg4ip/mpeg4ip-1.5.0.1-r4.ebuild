# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg4ip/mpeg4ip-1.5.0.1-r4.ebuild,v 1.5 2008/05/07 21:12:13 flameeyes Exp $

WANT_AUTOMAKE="1.9"

inherit eutils multilib autotools

DESCRIPTION="MPEG 4 implementation library"
HOMEPAGE="http://www.mpeg4ip.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="MPL-1.1 LGPL-2 GPL-2 LGPL-2.1 BSD UCL MPEG4"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ipv6 mmx v4l2 xvid nas alsa esd arts ffmpeg a52 mpeg2 lame aac id3 player mp4live x264"

RDEPEND=" media-libs/libsdl
	player? (
		>=x11-libs/gtk+-2
		ffmpeg? ( >=media-video/ffmpeg-0.4.7 )
		mpeg2? ( media-libs/libmpeg2 )
		id3? ( media-libs/libid3tag )
		a52? ( media-libs/a52dec )
	)
	xvid? ( >=media-libs/xvid-0.9.8 )
	mp4live? (
		>=x11-libs/gtk+-2
		lame? ( >=media-sound/lame-3.92 )
		aac? ( >=media-libs/faac-1.24-r1 )
		ffmpeg? ( >=media-video/ffmpeg-0.4.7 )
		x264? ( media-libs/x264 )
	)
	nas? ( media-libs/nas x11-libs/libXt )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	=media-libs/libmp4v2-1.5.0.1*
	!<media-libs/faad2-2.0-r9 "

DEPEND="${RDEPEND}
	>=x11-libs/gtk+-2
	media-libs/alsa-lib
	>=dev-libs/glib-2
	dev-util/pkgconfig
	player? ( mmx? ( >=dev-lang/nasm-0.98.19 ) )"

pkg_setup() {
	if ! built_with_use media-libs/libsdl X;
	then
		eerror "media-libs/libsdl does not has X support"
		eerror "You need to rebuild media-libs/libsdl with USE=X"
		die
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/mpeg4ip-1.4.1-disable-faac-test.patch"
	epatch "${FILESDIR}/${P}-x264.patch"
	epatch "${FILESDIR}/mpeg4ip-1.5.0.1-newffmpeg.patch"
	epatch "${FILESDIR}/mpeg4ip-1.5.0.1-lX11.patch"
	epatch "${FILESDIR}/mpeg4ip-1.5.0.1-as-needed.patch"
	epatch "${FILESDIR}/${P}-gcc42.patch"
	epatch "${FILESDIR}/${P}-nasm-r.patch"
	epatch "${FILESDIR}/mpeg4ip-1.5.0.1-avcodec_extern_c.patch"
	epatch "${FILESDIR}/${P}+gcc-4.3.patch"

	find "${S}" -name Makefile.am -print0 | xargs -0 \
		sed -i -e 's:-Werror::'

	find "${S}" -name configure.in -print0 | xargs -0 \
		sed -i -e 's:-Werror::'

	eautoreconf
}

src_compile() {
	local myconf
	myconf=" --datadir=/usr/share/mpeg4ip
			$(use_enable ipv6)
			$(use_enable ppc)
			$(use_enable player)
			$(use_enable mp4live)
			$(use_enable xvid)
			$(use_enable nas)
			$(use_enable esd)
			$(use_enable alsa)
			$(use_enable arts)
			--disable-srtp" # need ot add libsrtp to portage

	# Those are possible for both player and mp4live
	if use player || use mp4live ; then
		myconf="${myconf} --enable-gtk-glib
			$(use_enable ffmpeg)"
	fi

	# Those are only relevant for the player
	use player && myconf="${myconf}
			$(use_enable mmx)
			$(use_enable a52 a52dec)
			$(use_enable mpeg2 mpeg2dec)
			$(use_enable id3 id3tags)"
	use player || myconf="${myconf}
			--disable-a52
			--disable-mmx
			--disable-mpeg2dec
			--disable-id3tags"

	# those can only be used for mp4live
	use mp4live && myconf="${myconf}
			$(use_enable v4l2)
			$(use_enable lame mp3lame)
			$(use_enable aac faac)
			$(use_enable x264)"
			# $(use_enable alsa mp4live-alsa)
	use mp4live || myconf="${myconf}
			--disable-v4l2
			--disable-mp3lame
			--disable-faac
			--disable-mp4live-alsa
			--disable-x264"

	./bootstrap --prefix=/usr \
		--host=${CHOST} \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--libdir=/usr/$(get_libdir) \
		--localstatedir=/var/lib \
		--disable-warns-as-err \
		--enable-server \
		${EXTRA_ECONF} \
		${myconf} || die "configure failed"

	sed -i -e 's:-Werror::' common/video/iso-mpeg4/src/Makefile || die "sed failed"

	emake || die "make failed"
}

src_install () {
	make install DESTDIR="${D}" || die "make install failed"

	rm -f "${D}"/usr/include/mp4.h
	rm -f "${D}"/usr/$(get_libdir)/libmp4v2*

	dodoc doc/MPEG4IP_Guide.pdf doc/*txt AUTHORS TODO

	dohtml doc/*.html FEATURES.html || die

	docinto ietf
	dodoc doc/ietf/*.txt || die

	docinto mcast
	dodoc doc/mcast/mcast.txt doc/mcast/mcast_example doc/mcast/playlist_example || die

}
