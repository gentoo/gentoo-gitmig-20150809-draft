# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/conglomerate/conglomerate-0.7.4.ebuild,v 1.1 2003/09/28 21:08:26 foser Exp $

inherit gnome2

DESCRIPTION="XML editor"
HOMEPAGE="http://www.conglomerate.org/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-libs/libxml2
	dev-libs/libxslt
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=x11-libs/gtksourceview-0.6"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README* TODO"

