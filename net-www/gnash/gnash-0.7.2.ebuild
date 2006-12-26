# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gnash/gnash-0.7.2.ebuild,v 1.5 2006/12/26 12:54:18 drizzt Exp $

inherit nsplugins kde-functions
set-kdedir

DESCRIPTION="Gnash is a GNU Flash movie player that supports many SWF v7 features"
HOMEPAGE="http://www.gnu.org/software/gnash"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc -sparc ~x86 ~x86-fbsd"
IUSE="agg gstreamer ffmpeg kde nsplugin xml video_cards_i810"
#dmalloc, broken see bug 142939
#dmalloc? ( dev-libs/dmalloc )
#		$(use_enable dmalloc) \

RDEPEND="
	xml? ( dev-libs/libxml2 )
	sys-libs/zlib
	media-libs/jpeg
	media-libs/libogg
	media-libs/libpng
	net-misc/curl
	!ffmpeg? ( media-libs/libmad )
	ffmpeg? ( media-video/ffmpeg )
	gstreamer? ( media-libs/gstreamer
		|| (
			media-plugins/gst-plugins-ffmpeg
			media-plugins/gst-plugins-mad
			media-plugins/gst-plugins-lame
		)
	)
	!gstreamer? ( media-libs/libsdl )
	dev-libs/boost
	|| (
		( x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXmu
		x11-libs/libXt
		x11-proto/xproto )
		virtual/x11
	)
	dev-libs/atk
	dev-libs/glib
	>x11-libs/gtk+-2
	x11-libs/pango
	!agg? ( virtual/opengl x11-libs/gtkglext )
	kde? ( kde-base/kdelibs )
	agg? ( x11-libs/agg )"
	#cairo? ( x11-libs/cairo )

pkg_setup() {
	if use agg && use kde; then
		eerror "Building klash with the agg based renderer is not supportet"
		eerror "Please USE -kde or -agg"
		die "kde and agg not supported at the same time"
	fi
}

src_compile() {
	local myconf

	use nsplugin && myconf="${myconf} --with-plugindir=/opt/netscape/plugins"

	#--enable-renderer=engine Specify rendering engine:
	#				OpenGL (default)
	#				Cairo  (experimental)
	#cairo: does not work for plugins yet, offers flash for non-accelerated gfx?
	#if use cairo; then
	#	myconf="${myconf} --enable-renderer=cairo"
	#fi
	if use agg; then
		myconf="${myconf} --enable-renderer=agg"
	fi
	#--enable-gui=flavor Specify gui flavor:
	#				GTK
	#				SDL -> has no controls, we do not USE it
	#$(use_enable gtk glext) with USE=-gtk, fails to detect gtkglext, bug 135010
	#--enable-sound=gst,sdl
	if use gstreamer; then
		myconf="${myconf} --enable-sound=gst"
	else
		myconf="${myconf} --enable-sound=sdl"
	fi

	if use ffmpeg; then
		myconf="${myconf} --with-mp3-decoder=ffmpeg"
	fi

	econf \
		$(use_enable nsplugin plugin) \
		$(use_enable xml) \
		$(use_enable video_cards_i810 i810-lod-bias) \
		--without-gcc-arch \
		$(use_enable kde klash) \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	use nsplugin && inst_plugin /opt/netscape/plugins/libgnashplugin.so \
		|| rm -rf ${D}/opt
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "ALPHA"
	ewarn "gnash is still in heavy development"
	ewarn "please report gnash bugs upstream to the gnash devs"
}
