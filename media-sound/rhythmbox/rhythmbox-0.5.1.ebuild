# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rhythmbox/rhythmbox-0.5.1.ebuild,v 1.1 2003/08/21 08:35:52 g2boojum Exp $

IUSE="mad oggvorbis gstreamer"

inherit gnome2

DESCRIPTION="An integrated music management application originally inspired by iTunes for GNOME 2"
HOMEPAGE="http://www.rhythmbox.org"
SRC_URI="mirror://sourceforge/rhythmbox/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc
	media-libs/flac
	>=media-libs/musicbrainz-2.0.0
	mad? ( media-sound/mad )
	oggvorbis? ( media-libs/libogg
		     media-libs/libvorbis )
	gstreamer? ( >=media-libs/gstreamer-0.6.2
		     >=media-libs/gst-plugins-0.6.2 )
	!gstreamer? ( media-libs/xine-lib )"

DOCS="AUTHORS ChangeLog DOCUMENTERS INTERNALS MAINTAINERS NEWS \
	README THANKS TODO"

src_compile() {

	if [ ! `use gstreamer` ]; then
		ewarn ""
		ewarn "You are installing rhythmbox with xine as the backend"
		ewarn "but gstreamer is the suggested backend for rhythmbox."
		ewarn "If you would like to install the gstreamer backend,"
		ewarn "hit ctrl-c and restart the emerge after adding gstreamer to USE"
		ewarn ""
		sleep 5
	fi

	local myconf="--with-gnu-ld"

	use gstreamer || myconf="${myconf} --enable-xine"

	use mad || myconf="${myconf} --disable-mp3"

	use oggvorbis || myconf="${myconf} --disable-vorbis"

	gnome2_src_compile ${myconf}
}
