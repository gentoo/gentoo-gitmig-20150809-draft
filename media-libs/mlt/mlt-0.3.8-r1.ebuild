# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mlt/mlt-0.3.8-r1.ebuild,v 1.1 2009/04/22 11:08:39 loki_val Exp $

EAPI=1

inherit kde-functions eutils toolchain-funcs multilib

DESCRIPTION="MLT is an open source multimedia framework, designed and developed
for television broadcasting"
HOMEPAGE="http://mlt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="dv compressed-lumas ffmpeg gtk jack kde libsamplerate mmx qt3 qt4 quicktime sdl sox sse vorbis xine xml"

RDEPEND="ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20080326 )
	dv?	( >=media-libs/libdv-0.104 )
	xml?	( >=dev-libs/libxml2-2.5 )
	vorbis?	( >=media-libs/libvorbis-1.1.2 )
	sdl?	( >=media-libs/libsdl-1.2.10
		  >=media-libs/sdl-image-1.2.4 )
	libsamplerate? ( >=media-libs/libsamplerate-0.1.2 )
	jack?	( media-sound/jack-audio-connection-kit
			  media-libs/ladspa-sdk
			  >=dev-libs/libxml2-2.5 )
	gtk?	( >=x11-libs/gtk+-2
		  x11-libs/pango )
	sox? ( media-sound/sox )
	quicktime? ( media-libs/libquicktime )
	xine? ( >=media-libs/xine-lib-1.1.2_pre20060328-r7 )
	qt3? ( x11-libs/qt:3
		kde? ( kde-base/kdelibs:3.5 ) )
	!qt3?   ( qt4? ( x11-libs/qt-gui:4 ) )"

DEPEND="${RDEPEND}
	compressed-lumas? ( media-gfx/imagemagick )"

pkg_setup() {
	local fail="USE sox needs also USE libsamplerate enabled."

	if use sox && ! use libsamplerate; then
		eerror "${fail}"
		die "${fail}"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/mlt-0.2.3-nostrip.patch
	epatch "${FILESDIR}"/${PN}-0.3.6-qimage.patch
	epatch "${FILESDIR}"/${PN}-0.3.8-as-needed.patch
}

src_compile() {
	tc-export CC

	local myconf="	--enable-gpl
			--enable-motion-est
			$(use_enable dv)
			$(use_enable mmx)
			$(use_enable sse)
			$(use_enable gtk gtk2)
			$(use_enable vorbis)
			$(use_enable sdl)
			$(use_enable jack jackrack)
			$(use_enable sox)
			$(use_enable ffmpeg avformat)
			$(use_enable libsamplerate resample)
			$(use_enable xml westley)
			$(use_enable xine)"

	use ffmpeg && has_version ">=media-video/ffmpeg-0.4.9_p20070616-r20" &&
		myconf="${myconf} --avformat-swscale"

	(use quicktime && use dv) ||  myconf="${myconf} --disable-kino"

	use compressed-lumas && myconf="${myconf} --luma-compress"

	# Waiting for media-plugins/frei0r (bug 255321)
	myconf="${myconf} --disable-frei0r"

	if use qt3; then
		myconf="${myconf} --disable-kdenlive"
	else
		myconf="${myconf} $(use_enable kde kdenlive)"
	fi

	if use qt3; then
		myconf="${myconf} --qimage-libdir=$QTDIR/$(get_libdir)
			--qimage-includedir=$QTDIR/include"
		if use kde; then
			# compile extra image formats using kde
			set-kdedir 3.5
			myconf="${myconf} --kde-libdir=$KDEDIR/$(get_libdir)
				--kde-includedir=$KDEDIR/include"
		fi
	elif use qt4; then
		myconf="${myconf} --qimage-libdir=/usr/$(get_libdir)/qt4
			--qimage-includedir=/usr/include/qt4"
	else
		myconf="${myconf} --disable-qimage"
	fi

	econf ${myconf} || die "econf failed"
	sed -i -e s/^OPT/#OPT/ "${S}/config.mak"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc docs/*.txt ChangeLog README docs/TODO

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r demo
}
