# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-2.2.0.ebuild,v 1.1 2003/01/31 02:36:36 foser Exp $

#FIXME SANDBOX
addwrite /usr/share/
inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Multimedia related programs for the Gnome2 desktop"
HOMEPAGE="http://www.prettypeople.org/~iain/gnome-media/"
LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=media-sound/esound-0.2.29
	>=dev-libs/glib-2.0.6
	>=gnome-base/libgnomeui-2.1
	>=gnome-base/gconf-1.2.1
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/libbonobo-2.1
	>=gnome-base/bonobo-activation-2.1
	>=app-text/scrollkeeper-0.3.11
	>=gnome-base/gail-1.1
	>=media-libs/gst-plugins-0.5.2"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22
	${RDEPEND}"

DOCS="AUTHORS COPYING COPYING-DOCS  ChangeLog INSTALL NEWS README TODO"
