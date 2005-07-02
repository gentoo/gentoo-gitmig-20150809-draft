# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtranslator/gtranslator-1.1.6.ebuild,v 1.1 2005/07/02 15:57:37 chainsaw Exp $

inherit gnome2

DESCRIPTION="An enhanced gettext po file editor for GNOME"
HOMEPAGE="http://gtranslator.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtranslator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

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
