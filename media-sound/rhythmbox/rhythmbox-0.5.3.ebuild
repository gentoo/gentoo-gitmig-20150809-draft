# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rhythmbox/rhythmbox-0.5.3.ebuild,v 1.1 2003/09/08 23:50:23 foser Exp $

inherit gnome2

DESCRIPTION="A music and playlist organizer and player"
HOMEPAGE="http://web.rhythmbox.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="oggvorbis mad xine"

RDEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/gconf-2.0
	>=media-libs/flac-1.0
	>=media-libs/musicbrainz-2.0
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
	mad? ( >=media-libs/libid3tag-0.15 )
	!xine? ( >=media-libs/gstreamer-0.6.3
		>=media-libs/gst-plugins-0.6.3
		>=media-libs/gst-plugins-gnomevfs-0.6.3
		mad? ( >=media-libs/gst-plugins-mad-0.6.3 )		
		oggvorbis? ( >=media-libs/gst-plugins-vorbis-0.6.3 )
		)
	xine? ( >=media-libs/xine-lib-1_rc0 )"		
#		>=media-plugins/gst-plugins-flac-0.6.3		
# should we really force flac ?

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

use xine && G2CONF="${G2CONF} --enable-xine"

G2CONF="${G2CONF} \
	$(use_enable oggvorbis vorbis) \
	$(use_enable mad mp3) \
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
