# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg4ip/mpeg4ip-1.3.ebuild,v 1.1 2005/05/19 01:53:03 tester Exp $

inherit eutils multilib

DESCRIPTION="MPEG 4 implementation library"

HOMEPAGE="http://www.mpeg4ip.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MPL-1.1 LGPL-2 GPL-2 LGPL-2.1 BSD UCL MPEG4"

SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE="ipv6 mmx v4l2 xvid nas alsa esd arts ffmpeg a52 mpeg2 lame aac id3 player mp4live"

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
		aac? ( >=media-libs/faac-1.20.1 )
		ffmpeg? ( >=media-video/ffmpeg-0.4.7 )
	)
	nas? ( media-libs/nas virtual/x11 )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )"

DEPEND="${RDEPEND}
	sys-devel/libtool
	sys-devel/autoconf
	sys-devel/automake
	player?( x86? ( mmx? ( >=dev-lang/nasm-0.98.19 ) ) )"


pkg_setup() {
	if use aac && grep -q /usr/lib/libmp4v2.la /usr/lib/libfaac.la; then
		eerror "libfaac is compiled against libmp4v2"
		eerror "Please remove faad2 and mpeg4ip then recompile faac"
		die
	fi

}

src_compile() {
	cd ${S}

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
			$(use_enable arts)"


	# Those are possible for both player and mp4live
	if use player || ( use server && use mp4live ); then
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
	use server && use mp4live && myconf="${myconf}
			$(use_enable v4l2)
			$(use_enable lame mp3lame)
			$(use_enable aac faac)"
	{ use server && use mp4live; } || myconf="${myconf}
			--disable-v4l2
			--disable-mp3lame
			--disable-faac"

	./bootstrap --prefix=/usr \
		--host=${CHOST} \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--libdir=/usr/$(get_libdir) \
		--localstatedir=/var/lib \
		${EXTRA_ECONF} \
		${myconf} || die "configure failed"


	emake || die "make failed"
}

src_install () {
	cd ${S}
	make install DESTDIR="${D}" || die "make install failed"

	dodoc doc/MPEG4IP_Guide.pdf doc/*txt AUTHORS COPYING TODO

	dohtml doc/*.html FEATURES.html || die

	docinto ietf
	dodoc doc/ietf/*.txt || die

	docinto mcast
	dodoc doc/mcast/mcast.txt doc/mcast/mcast_example doc/mcast/playlist_example || die

}
