# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rhythmbox/rhythmbox-0.5.3.ebuild,v 1.5 2003/10/13 16:32:58 foser Exp $

inherit gnome2

DESCRIPTION="A music and playlist organizer and player"
HOMEPAGE="http://web.rhythmbox.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="oggvorbis mad xine flac"

RDEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/gconf-2.0
	>=media-libs/musicbrainz-2.0
	flac? ( >=media-libs/flac-1.0 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
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

use xine && G2CONF="${G2CONF} --enable-xine"
use flac && G2CONF="${G2CONF} --enable-flac"

G2CONF="${G2CONF} \
	$(use_enable oggvorbis vorbis) \
	$(use_enable mad mp3) \
	--disable-schemas-install"

src_unpack( ) {

	unpack ${A}

	cd ${S}
	# sandbox errors work around
	gnome2_omf_fix ${S}/help/C/Makefile.in

	# Force orbit regeneration (#28739)
	rm -f ${S}/corba/*.{c,h}

}

DOCS="AUTHORS COPYING ChangeLog DOCUMENTERS INSTALL INTERNALS \
	  MAINTAINERS NEWS README THANKS TODO"

export GST_INSPECT=/bin/true
