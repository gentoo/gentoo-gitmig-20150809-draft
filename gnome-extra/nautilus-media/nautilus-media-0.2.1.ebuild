# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-media/nautilus-media-0.2.1.ebuild,v 1.8 2003/07/19 23:27:59 tester Exp $

inherit gnome2

IUSE=""
S=${WORKDIR}/${P}
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
