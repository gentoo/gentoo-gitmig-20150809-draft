# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rhythmbox/rhythmbox-0.5.0.ebuild,v 1.3 2003/08/20 16:39:27 tester Exp $

# Comments wrt gstreamer are in the build.  Not all the gstreamer plugins
# required for support are in portage yet.

IUSE="mad oggvorbis" # gstreamer

inherit gnome2

DESCRIPTION="An integrated music management application originally inspired by iTunes for GNOME 2"
HOMEPAGE="http://www.rhythmbox.org"
SRC_URI="mirror://sourceforge/rhythmbox/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND="virtual/glibc
	media-libs/flac
	media-libs/xine-lib
	>=media-libs/musicbrainz-2.0.0
	mad? ( media-sound/mad )
	oggvorbis? ( media-libs/libogg
		     media-libs/libvorbis )"

#	gstreamer? ( >=media-libs/gstreamer-0.6.2
#		     >=media-libs/gst-plugins-0.6.2
#		     >=media-libs/gst-plugins-cdparanoia-0.6.2 )
#	!gstreamer? ( media-libs/xine-lib )
#	oggvorbis? ( gstreamer? ( >=media-libs/gst-plugins-vorbis-0.6.2 ) )
#	mad? ( gstreamer? ( >=media-libs/gst-plugins-mad-0.6.2 ) )

DOCS="AUTHORS ChangeLog DOCUMENTERS INTERNALS MAINTAINERS NEWS \
	README THANKS TODO"

src_compile() {
	local myconf="--with-gnu-ld --enable-xine"
	#use gstreamer || myconf="${myconf} --enable-xine"

	use mad || myconf="${myconf} --disable-mp3"

	use oggvorbis || myconf="${myconf} --disable-vorbis"

	gnome2_src_compile ${myconf}
}

