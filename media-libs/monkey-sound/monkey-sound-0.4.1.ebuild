# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/monkey-sound/monkey-sound-0.4.1.ebuild,v 1.4 2002/07/23 00:12:54 seemant Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Library wrapping gstreamer able to play media file"
SRC_URI="http://www.rhythmbox.org/download/${P}.tar.gz"
HOMEPAGE="http://www.rhythmbox.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=x11-libs/gtk+-2.0.0
	 >=dev-libs/atk-1.0.0
	 >=dev-libs/glib-2.0.0
	 >=media-libs/audiofile-0.2.3
	 >=gnome-base/gnome-vfs-1.9.16
	 >=media-libs/gstreamer-0.3.4
	 >=gnome-base/gconf-1.1.10
	 >=gnome-base/libglade-1.99.12
	 >=gnome-base/ORBit2-2.4.0
	 sys-devel/gettext
	 sys-libs/zlib
	 media-libs/libogg
	 media-libs/libvorbis
	 >=media-sound/mad-0.14.2b"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

LIBTOOL_FIX="1"

DOC="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README THANKS TODO"
SCHEMA="monkey-sound.schemas"
