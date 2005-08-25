# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonoboui/libbonoboui-2.10.0.ebuild,v 1.2 2005/08/25 02:39:24 leonardop Exp $

inherit gnome2

DESCRIPTION="User Interface part of libbonobo"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE="doc static"

RDEPEND=">=gnome-base/libgnomecanvas-1.116
	>=gnome-base/libbonobo-2.3.3
	>=gnome-base/libgnome-1.116
	>=dev-libs/libxml2-2.4.20
	>=gnome-base/gconf-1.1.9
	>=x11-libs/gtk+-2.3.1
	>=dev-libs/glib-2.3.2
	>=gnome-base/libglade-1.99.11"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	dev-util/intltool
	doc? ( >=dev-util/gtk-doc-1 )"

RESTRICT="test"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="${G2CONF} $(use_enable static)"
