# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glunarclock/glunarclock-0.32.4.ebuild,v 1.2 2005/06/19 19:34:37 smithj Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome Moon Phase Panel Applet"

HOMEPAGE="http://glunarclock.sourceforge.net/"
SRC_URI="mirror://sourceforge/glunarclock/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-i18n-gentoo.patch
}

RDEPEND=">=x11-libs/gtk+-2.1.0
		>=gnome-base/libgnome-2.0.0
		>=gnome-base/libgnomeui-2.0.0
		>=gnome-base/gnome-vfs-1.9.16
		>=gnome-base/gconf-1.1.11
		>=gnome-base/libgtop-2.0.0
		>=x11-libs/libwnck-0.13
		>=gnome-base/libglade-2.0.0
		>=gnome-base/gnome-panel-2.0.0"

DEPEND="${RDEPEND}
		>=dev-util/intltool-0.29
		>=app-text/scrollkeeper-0.1.4
		dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING* INSTALL README"
