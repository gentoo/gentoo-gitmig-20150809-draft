# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-2.0.2.5.ebuild,v 1.1 2002/09/06 04:45:58 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Multimedia related programs for the Gnome2 desktop"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/ http://www.prettypeople.org/~iain/gnome-media/"
LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="x86"

RDEPEND=">=media-sound/esound-0.2.29
	>=dev-libs/glib-2.0.6
	>=gnome-base/libgnomeui-2.0.5
	>=gnome-base/gconf-1.2.1
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/bonobo-activation-1.0.3
	>=app-text/scrollkeeper-0.3.11
	>=gnome-base/gail-0.17"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22
	${RDEPEND}"


LIBTOOL_FIX="0"
G2CONF="${G2CONF} --enable-platform-gnome-2"
src_unpack () {
	unpack ${A}
	cd ${S}
	find .  -exec touch "{}" \;
}

DOCS="AUTHORS COPYING COPYING-DOCS  ChangeLog INSTALL NEWS README TODO"
SCHEMA="CDDB-Slave2.schemas gnome-cd.schemas gnome-sound-recorder.schemas gnome-volume-control.schemas"

