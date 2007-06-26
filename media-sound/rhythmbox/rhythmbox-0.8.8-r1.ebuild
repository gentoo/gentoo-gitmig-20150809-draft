# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rhythmbox/rhythmbox-0.8.8-r1.ebuild,v 1.11 2007/06/26 02:15:14 mr_bones_ Exp $

inherit gnome2 eutils

DESCRIPTION="Music management and playback software for GNOME"
HOMEPAGE="http://www.rhythmbox.org/"
LICENSE="GPL-2"

KEYWORDS="x86 ppc amd64 sparc"
#IUSE="vorbis xine flac aac mad pda"
IUSE="vorbis flac aac mad pda"
SLOT="0"

RDEPEND=">=x11-libs/gtk+-2.2.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libbonobo-2
	=media-libs/gst-plugins-0.8*
	=media-plugins/gst-plugins-gnomevfs-0.8*
	vorbis? ( =media-plugins/gst-plugins-vorbis-0.8*
	            =media-plugins/gst-plugins-ogg-0.8* )
	mad? ( =media-plugins/gst-plugins-mad-0.8* )
	flac? ( =media-plugins/gst-plugins-flac-0.8* )
	aac? ( =media-plugins/gst-plugins-faad-0.8* )"

#	!xine? ( =media-libs/gst-plugins-0.8*
#		=media-plugins/gst-plugins-gnomevfs-0.8*
#		vorbis? ( =media-plugins/gst-plugins-vorbis-0.8*
#		             =media-plugins/gst-plugins-ogg-0.8* )
#		mad? ( =media-plugins/gst-plugins-mad-0.8* )
#		flac? ( =media-plugins/gst-plugins-flac-0.8* )
#		aac? ( =media-plugins/gst-plugins-faad-0.8* ) )
#	xine? ( aac? ( >=media-libs/faad2-2.0_rc3 )
#		flac? ( >=media-libs/flac-1
#			>=media-libs/libid3tag-0.15.0b )
#		vorbis? ( >=media-libs/libvorbis-1 )
#		mad? ( >=media-libs/libid3tag-0.15.0b )
#		>=media-libs/xine-lib-1_rc3 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	app-text/scrollkeeper"

MAKEOPTS="${MAKEOPTS} -j1"

#use xine &&\
#	G2CONF="${G2CONF} --with-player=xine --with-metadata=monkeymedia" ||\
#	G2CONF="${G2CONF} --with-player=gstreamer --with-metadata=gstreamer"

G2CONF="${G2CONF} --with-player=gstreamer --with-metadata=gstreamer"

G2CONF="${G2CONF} \
	$(use_enable vorbis) \
	$(use_enable flac) \
	$(use_enable mad mp3) \
	$(use_enable aac mp4) \
	$(use_enable pda ipod) \
	--enable-mmkeys \
	--enable-audiocd \
	--disable-dashboard \
	--disable-schemas-install"

DOCS="AUTHORS COPYING ChangeLog DOCUMENTERS INSTALL INTERNALS \
	  MAINTAINERS NEWS README README.iPod THANKS TODO"

export GST_INSPECT=/bin/true

src_unpack()
{

	unpack ${A}
	cd ${S}
	gnome2_omf_fix ${S}/help/C/Makefile.in
	gnome2_omf_fix ${S}/help/ja/Makefile.in

	# Make it possible for gst rb to load shorten files
	epatch ${FILESDIR}/${PN}-0.8.7-gst_shn_support.patch
	# fix ipod crasher
	epatch ${FILESDIR}/${P}-ipod.patch
	# Fix empty X libs. Bug #91707
	epatch ${FILESDIR}/${P}-empty-xlib.patch

	autoconf || die "Autoconf failed"
}
