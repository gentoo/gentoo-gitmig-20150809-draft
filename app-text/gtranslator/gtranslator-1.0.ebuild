# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtranslator/gtranslator-1.0.ebuild,v 1.3 2004/06/24 22:38:15 agriffis Exp $

inherit gnome2

DESCRIPTION="An enhaned gettext po file editor for GNOME"
HOMEPAGE="http://www.gtranslator.org"
SRC_URI="http://www.${PN}.org/download/releases/${PV}/${P}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=dev-libs/libxml2-2.4.12
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.1.4
	>=dev-util/intltool-0.22
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README THANKS TODO"

