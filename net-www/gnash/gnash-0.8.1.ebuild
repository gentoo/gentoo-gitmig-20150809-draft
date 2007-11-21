# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gnash/gnash-0.8.1.ebuild,v 1.1 2007/11/21 09:19:53 uid895 Exp $

inherit nsplugins kde-functions qt3 multilib
set-kdedir eutils

DESCRIPTION="Gnash is a GNU Flash movie player that supports many SWF v7 features"
HOMEPAGE="http://www.gnu.org/software/gnash"
SRC_URI="mirror://gnu/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="agg opengl cairo gtk kde nsplugin gstreamer ffmpeg video_cards_i810"

RDEPEND="
	agg? ( >=x11-libs/agg-2.5 )
	cairo? ( x11-libs/cairo )
	opengl? (
		virtual/opengl
		gtk? (
			x11-libs/gtkglext
		)
	)
	gtk? (
		>x11-libs/gtk+-2
		x11-libs/pango
		dev-libs/glib
		dev-libs/atk
	)
	kde? ( kde-base/kdelibs )
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
	if ! ( use agg || use opengl || use cairo ); then
		eerror "No renderer was selected. Select one between AGG, OpenGL and cairo"
		eerror "They correspond to the agg, opengl and cairo USE flags"
		eerror "AGG is upstream's default, so it is probably a safe choice"
		die "None of the opengl, agg and cairo USE flags enabled"

	elif use agg && use opengl || use cairo && ( use agg || use opengl ); then
		eerror "More than one renderer was selected"
		eerror "Please select only one renderer between AGG, OpenGL and cairo"
		eerror "They correspond to the agg, opengl and cairo USE flags"
		eerror "AGG is upstream's default, so it is probably a safe choice"
		die "More than one USE flag enabled between opengl, agg and cairo"
	fi

	if use cairo && use kde; then
		eerror "The cairo renderer and the kde gui were selected"
		eerror "They are incompatible with each other"
		eerror "Disable one of them through the respective USE flag"
		die "cairo and kde USE flags enabled at the same time"
	fi

	if has_version '<dev-libs/boost-1.34' && ! built_with_use dev-libs/boost threads; then
		eerror "dev-libs/boost must have been built with the 'threads' USE flag enabled"
		die "dev-libs/boost not built with threads USE flag enabled"
	fi

	if use !ffmpeg && use !gstreamer; then
		eerror "No media handler was selected. Select one between FFmpeg and GStreamer"
		eerror "Enable one (and only one) of the ffmpeg and gstreamer USE flags"
		die "ffmpeg and gstreamer USE flags both disabled: no media handler selected"

	elif use ffmpeg && use gstreamer; then
		eerror "Both FFmpeg and GStreamer media handlers were selected"
		eerror "One, and only one, of the ffmpeg and gstreamer USE flags must be enabled"
		die "Both ffmpeg and gstreamer USE flags enabled"
	fi

	if use !kde && use !gtk; then
		eerror "No frontend was selected"
		eerror "At least one of the kde and gtk USE flags must be enabled"
		die "Both kde and gtk USE flags disabled: no frontend selected"
	fi

	if use nsplugin && use !gtk; then
		eerror "The Firefox plugin was selected but not the GTK frontend."
		eerror "Disable the nsplugin USE flag or enable the gtk USE flag"
		die "nsplugin USE flag enabled with required gtk USE flag disabled"
	fi
}

src_compile() {
	local myconf
	local gui

	if use nsplugin; then
		myconf="${myconf} --with-plugindir=/opt/netscape/plugins"
	else
		myconf="${myconf} --disable-nsapi"
	fi

	if use !kde; then
		myconf="${myconf} --disable-kparts"
	fi

	if use agg; then
		myconf="${myconf} --enable-renderer=agg"
	elif use opengl; then
		myconf="${myconf} --enable-renderer=ogl"
	else
		myconf="${myconf} --enable-renderer=cairo"
	fi

	if use gtk; then
		if use kde; then
			gui="gtk,kde";
		else
			gui=gtk
		fi
	else
		gui=kde
	fi

	if use gstreamer; then
		myconf="${myconf} --enable-media=gst"
	else
		myconf="${myconf} --enable-media=ffmpeg"
	fi

	econf ${myconf} \
		$(use_enable video_cards_i810 i810-lod-bias) \
		--enable-gui=${gui} \
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
