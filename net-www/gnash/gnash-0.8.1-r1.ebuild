# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gnash/gnash-0.8.1-r1.ebuild,v 1.2 2008/01/19 17:20:15 genstef Exp $

inherit nsplugins kde-functions qt3 multilib
set-kdedir eutils

DESCRIPTION="Gnash is a GNU Flash movie player that supports many SWF v7 features"
HOMEPAGE="http://www.gnu.org/software/gnash"
SRC_URI="mirror://gnu/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="agg cairo fbcon ffmpeg gstreamer gtk kde mad nsplugin opengl qt sdl video_cards_i810"

RDEPEND="
	agg? ( >=x11-libs/agg-2.5 )
	cairo? ( x11-libs/cairo )
	opengl? (
		virtual/opengl
		gtk? ( x11-libs/gtkglext )
	)
	!agg? ( !cairo? ( !opengl? ( >=x11-libs/agg-2.5 ) ) )
	gtk? (
		>x11-libs/gtk+-2
		x11-libs/pango
		dev-libs/glib
		dev-libs/atk
	)
	kde? ( kde-base/kdelibs )
	qt? ( x11-libs/qt )
	sdl? ( media-libs/libsdl )
	!gtk? ( !kde? ( !qt? ( !sdl? ( ( !fbcon? (
		>x11-libs/gtk+-2
		x11-libs/pango
		dev-libs/glib
		dev-libs/atk
		kde-base/kdelibs
	) ) ) ) ) )
	dev-libs/libxml2
	sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng
	net-misc/curl
	ffmpeg?	(
		media-libs/libsdl
		media-video/ffmpeg
	)
	gstreamer? (
		media-plugins/gst-plugins-ffmpeg
		media-plugins/gst-plugins-mad
	)
	mad? ( media-libs/libmad )
	dev-libs/boost
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXt
	x11-proto/xproto
	"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! use agg && ! use opengl && use cairo && use kde ; then
		eerror "The cairo renderer and the kde gui were selected"
		eerror "They are incompatible with each other"
		eerror "Disable one of them through the respective USE flag"
		die "cairo and kde USE flags enabled at the same time"
	fi

#( use fbcon || use fltk )
	if ! use agg && use opengl && use fbcon; then
		eerror "The opengl renderer and the fb/fltk guis were selected"
		eerror "They are incompatible with each other"
		eerror "Disable one of them through the respective USE flag"
		die "opengl and fbcon/fltk USE flags enabled at the same time"
	fi

	if use nsplugin && use !gtk ; then
		eerror "The Firefox plugin was selected but not the GTK frontend."
		eerror "Disable the nsplugin USE flag or enable the gtk USE flag"
		die "nsplugin USE flag enabled with required gtk USE flag disabled"
	fi

	if has_version '<dev-libs/boost-1.34' && ! built_with_use dev-libs/boost threads ; then
		eerror "dev-libs/boost must have been built with the 'threads' USE flag enabled"
		die "dev-libs/boost not built with threads USE flag enabled"
	fi
}

src_compile() {
	local myconf

	if use nsplugin ; then
		myconf="${myconf} --with-plugindir=/opt/netscape/plugins"
	else
		myconf="${myconf} --disable-nsapi"
	fi

	if use agg ; then
		myconf="${myconf} --enable-renderer=agg"
	elif use opengl ; then
		myconf="${myconf} --enable-renderer=ogl"
	elif use cairo ; then
		myconf="${myconf} --enable-renderer=cairo"
	else
		ewarn "You did not select a renderer from: agg cairo opengl"
		ewarn " - Default of agg has been selected for you"
		myconf="${myconf} --enable-renderer=agg"
	fi

	local gui=""
	use fbcon && gui="${gui},fb"
	#use fltk && gui="${gui},fltk"
	use gtk && gui="${gui},gtk"
	use kde && gui="${gui},kde"
	use qt && gui="${gui},qt"
	use sdl && gui="${gui},sdl"
	gui=${gui#,}
	if [[ -z ${gui} ]] ; then
		ewarn "You did not select a gui from: fbcon gtk kde qt sdl" #fltk
		ewarn " - Default of gtk,kde has been selected for you"
		gui="gtk,kde"
	fi

	if use ffmpeg ; then
		myconf="${myconf} --enable-media=ffmpeg"
	elif use gstreamer ; then
		myconf="${myconf} --enable-media=gst"
	elif use mad ; then
		myconf="${myconf} --enable-media=mad"
	else
		ewarn "You did not select media: ffmpeg gstreamer mad"
		ewarn " - You will not have sound"
		myconf="${myconf} --enable-media=ffmpeg"
	fi

	econf \
		$(use_enable video_cards_i810 i810-lod-bias) \
		--enable-gui=${gui} \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
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
