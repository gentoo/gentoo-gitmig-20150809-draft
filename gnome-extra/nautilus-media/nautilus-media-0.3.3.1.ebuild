# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-media/nautilus-media-0.3.3.1.ebuild,v 1.13 2004/03/17 00:27:55 geoman Exp $

inherit gnome2

DESCRIPTION="Media plugins for Nautilus (audio view and info tab)"
HOMEPAGE="http://www.gstreamer.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64 ~mips"
IUSE="oggvorbis mad"

RDEPEND=">=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2.2
	>=media-libs/gstreamer-0.6.3
	>=media-libs/gst-plugins-0.6.3
	>=media-plugins/gst-plugins-gnomevfs-0.6.3
	>=media-plugins/gst-plugins-libpng-0.6.3
	oggvorbis? ( >=media-plugins/gst-plugins-vorbis-0.6.3 )
	mad? ( >=media-plugins/gst-plugins-mad-0.6.3 )"

# FIXME : flac support dep (?)

DEPEND=">=dev-util/intltool-0.18
	>=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README TODO"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-0.2.2-fix_DATADIR.patch
	epatch ${FILESDIR}/${P}-gcc2_fix.patch

}
