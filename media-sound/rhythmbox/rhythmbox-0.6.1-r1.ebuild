# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rhythmbox/rhythmbox-0.6.1-r1.ebuild,v 1.3 2004/02/12 17:01:22 leonardop Exp $

inherit gnome2

DESCRIPTION="Music management and playback software for GNOME"
HOMEPAGE="http://web.rhythmbox.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="oggvorbis mad xine flac faad"

RDEPEND=">=x11-libs/gtk+-2.2.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libbonobo-2
	>=media-libs/musicbrainz-2
	faad? ( >=media-libs/faad2-2.0_rc3 )
	flac? ( >=media-libs/flac-1 )
	oggvorbis? ( >=media-libs/libvorbis-1 )
	mad? ( >=media-libs/libid3tag-0.15 )
	!xine? ( >=media-libs/gstreamer-0.6.3
		>=media-libs/gst-plugins-0.6.3
		>=media-plugins/gst-plugins-gnomevfs-0.6.3
		flac? ( >=media-plugins/gst-plugins-flac-0.6.3 )
		mad? ( >=media-plugins/gst-plugins-mad-0.6.3 )
		oggvorbis? ( >=media-plugins/gst-plugins-vorbis-0.6.3 )
		)
	xine? ( >=media-libs/xine-lib-1_rc0 )"

# REMIND : should we really force flac ?
# I want to drop flac deps when rb get proper gst only/non monkey-media
# flac support. Made it a local USE flag for now
# <foser@gentoo.org> 06 Oct 2003

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper"

MAKEOPTS="${MAKEOPTS} -j1"

use xine && G2CONF="${G2CONF} --enable-xine"
use flac && G2CONF="${G2CONF} --enable-flac"

G2CONF="${G2CONF} \
	$(use_enable oggvorbis vorbis) \
	$(use_enable mad mp3) \
	$(use_enable faad mp4 ) \
	--disable-schemas-install"

src_unpack( ) {

	unpack ${A}

	cd ${S}
	# sandbox errors work around
	gnome2_omf_fix ${S}/help/C/Makefile.in

}

DOCS="AUTHORS COPYING ChangeLog DOCUMENTERS INSTALL INTERNALS \
	  MAINTAINERS NEWS README THANKS TODO"

export GST_INSPECT=/bin/true
