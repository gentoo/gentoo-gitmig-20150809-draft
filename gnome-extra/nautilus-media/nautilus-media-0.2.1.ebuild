# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-media/nautilus-media-0.2.1.ebuild,v 1.9 2003/08/07 03:42:26 vapier Exp $

inherit gnome2

DESCRIPTION="Media plugins for Nautilus"
HOMEPAGE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha sparc amd64"

RDEPEND=">=media-libs/gstreamer-0.5.2
	>=media-libs/gst-plugins-0.5.2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2.2"
DEPEND=">=dev-util/intltool-0.18
	>=dev-util/pkgconfig-0.12.0
	>=gnome-base/gconf-1.2
	${RDEPEND}"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README TODO"
