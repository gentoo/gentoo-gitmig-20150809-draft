# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mlt/mlt-0.4.4.ebuild,v 1.2 2009/07/05 23:10:50 yngwin Exp $

EAPI="2"

inherit kde-functions eutils toolchain-funcs multilib

DESCRIPTION="An open source multimedia framework, designed and developed for television broadcasting"
HOMEPAGE="http://mlt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="compressed-lumas dv debug ffmpeg frei0r gtk jack kde libsamplerate melt
mmx qt3 qt4 quicktime sdl sse vorbis xine xml"

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
	frei0r? ( media-plugins/frei0r-plugins )
	gtk?	( x11-libs/gtk+:2
		  x11-libs/pango )
	quicktime? ( media-libs/libquicktime )
	xine? ( >=media-libs/xine-lib-1.1.2_pre20060328-r7 )
	!qt4? ( qt3? ( x11-libs/qt:3
		kde? ( kde-base/kdelibs:3.5 ) ) )
	qt4? ( x11-libs/qt-gui:4 )
	!media-libs/mlt++"
#	sox? ( media-sound/sox )

DEPEND="${RDEPEND}
	compressed-lumas? ( media-gfx/imagemagick )"

#pkg_setup() {
#    local fail="USE sox needs also USE libsamplerate enabled."
#
#    if use sox && ! use libsamplerate; then
#        eerror "${fail}"
#        die "${fail}"
#    fi
#}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.3.6-qimage.patch
}

src_configure() {
	tc-export CC

	local myconf="	--enable-gpl
		--enable-motion-est
		$(use_enable debug)
		$(use_enable dv)
		$(use_enable sse)
		$(use_enable gtk gtk2)
		$(use_enable vorbis)
		$(use_enable sdl)
		$(use_enable jack jackrack)
		$(use_enable ffmpeg avformat)
		$(use_enable frei0r)
		$(use_enable melt)
		$(use_enable libsamplerate resample)
		$(use_enable xml)
		$(use_enable xine)
		--disable-sox"
		#$(use_enable sox)  FIXME

	use ffmpeg && myconf="${myconf} --avformat-swscale"

	(use quicktime && use dv) ||  myconf="${myconf} --disable-kino"

	use compressed-lumas && myconf="${myconf} --luma-compress"

	use x86 && myconf="${myconf} $(use_enable mmx)"

	if use qt3; then
		myconf="${myconf} --disable-kdenlive"
	else
		myconf="${myconf} $(use_enable kde kdenlive)"
	fi

	if use qt4; then
		myconf="${myconf} --qimage-libdir=/usr/$(get_libdir)/qt4
			--qimage-includedir=/usr/include/qt4"
	elif use qt3; then
		myconf="${myconf} --qimage-libdir=$QTDIR/$(get_libdir)
			--qimage-includedir=$QTDIR/include"
		if use kde; then
			# compile extra image formats using kde
			set-kdedir 3.5
			myconf="${myconf} --kde-libdir=$KDEDIR/$(get_libdir)
				--kde-includedir=$KDEDIR/include"
		fi
	else
		myconf="${myconf} --disable-qimage"
	fi

	use melt || sed -i -e "s;src/melt;;" Makefile

	# TODO: add swig language bindings
	# see also http://www.mltframework.org/twiki/bin/view/MLT/ExtremeMakeover

	econf ${myconf}
	sed -i -e s/^OPT/#OPT/ "${S}/config.mak"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc docs/*.txt ChangeLog README docs/TODO

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r demo
}
