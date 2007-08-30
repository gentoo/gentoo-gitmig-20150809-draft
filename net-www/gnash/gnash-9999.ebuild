# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gnash/gnash-9999.ebuild,v 1.5 2007/08/30 07:52:00 genstef Exp $

WANT_AUTOCONF=latest
inherit nsplugins autotools cvs kde-functions qt3 multilib
set-kdedir

DESCRIPTION="Gnash is a GNU Flash movie player that supports many SWF v7 features"
HOMEPAGE="http://www.gnu.org/software/gnash"
ECVS_SERVER="cvs.sv.gnu.org:/sources/${PN}"
ECVS_MODULE="${PN}"
S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="agg gstreamer ffmpeg kde mad nsplugin xml video_cards_i810"
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
	mad? ( media-libs/libmad )
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
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXt
	x11-proto/xproto
	dev-libs/atk
	dev-libs/glib
	>x11-libs/gtk+-2
	x11-libs/pango
	!agg? ( virtual/opengl x11-libs/gtkglext )
	kde? ( kde-base/kdelibs )
	agg? ( x11-libs/agg )"
	#cairo? ( x11-libs/cairo )
DEPEND="${RDEPEND} dev-util/pkgconfig"

pkg_setup() {
	if use agg && use kde; then
		eerror "Building klash with the agg based renderer is not supported"
		eerror "Please USE -kde or -agg"
		die "kde and agg not supported at the same time"
	fi

	if has_version '<dev-libs/boost-1.34' && ! built_with_use dev-libs/boost threads; then
		eerror "dev-libst/boost has to be built with the 'threads' USE flag"
		die "dev-libs/boost not built with threads"
	fi

	if use mad && ( use !ffmpeg && use !gstreamer ) && ( use nsplugin || use xml ); then
		eerror "Building Gnash using the mad media handler is incompatible with the nsplugin or xml USE flags"
		die "nsplugin and xml not supported with mad media handler"
	fi

	if use !mad && use !ffmpeg && use !gstreamer; then
		eerror "You are trying to build Gnash without choosing a media handler"
		eerror "Please enable one of the following ffmpeg,gstreamer or mad(mp3 audio only)"
		die "No media handler selected !"
	fi
}

src_unpack() {
	cvs_src_unpack
	cd ${S}
	./autogen.sh
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
	#--enable-media=gst||ffmpeg||mad
	if use mad && use !ffmpeg && use !gstreamer; then
		myconf="${myconf} --enable-media=mad"
	fi

	if use gstreamer && use !ffmpeg; then
		myconf="${myconf} --enable-media=gst"
	fi

	if use ffmpeg; then
		myconf="${myconf} --enable-media=ffmpeg"
	fi

	if use kde; then
		myconf="${myconf} --enable-klash --with-qt-incl=${QTDIR}/include
			--with-qt-lib=${QTDIR}/$(get_libdir)"
	else
		myconf="${myconf} --disable-klash"
	fi

	econf \
		$(use_enable nsplugin plugin) \
		$(use_enable xml) \
		$(use_enable video_cards_i810 i810-lod-bias) \
		--without-gcc-arch --disable-debugger \
		${myconf} || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	use nsplugin && inst_plugin /opt/netscape/plugins/libgnashplugin.so \
		|| rm -rf "${D}/opt"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "ALPHA"
	ewarn "gnash is still in heavy development"
	ewarn "please report gnash bugs upstream to the gnash devs"
}
