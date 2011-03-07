# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/conglomerate/conglomerate-0.9.1.ebuild,v 1.3 2011/03/07 00:03:17 nirbheek Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="An XML editor designed for DocBook and similar formats"
HOMEPAGE="http://www.conglomerate.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc spell"

RDEPEND=">=x11-libs/gtk+-2.4:2
	dev-libs/libxml2:2
	dev-libs/libxslt
	>=gnome-base/libgnomeprint-1.116:2.2
	>=gnome-base/libgnomeprintui-1.116:2.2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2:2.0
	>=gnome-base/gconf-2:2
	x11-libs/gtksourceview:1.0
	spell? ( >=app-text/enchant-0.1 )
	"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.30
	dev-util/pkgconfig
	app-text/scrollkeeper
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS BUGS ChangeLog INSTALL NEWS README* TODO"

G2CONF="${G2CONF} $(use_enable spell enchant) --enable-printing"
