# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gst-editor/gst-editor-0.5.0.ebuild,v 1.5 2003/07/12 14:28:13 aliz Exp $

inherit gnome2

DESCRIPTION="GStreamer graphical pipeline editor"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.6
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libglade-2
	app-text/scrollkeeper"

DEPEND="${RDEPEND}

	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS COPYING ChangeLog HACKING IDEAS NEWS README RELEASE TODO"
