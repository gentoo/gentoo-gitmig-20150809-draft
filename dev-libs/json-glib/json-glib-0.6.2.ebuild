# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/json-glib/json-glib-0.6.2.ebuild,v 1.1 2009/06/13 08:09:05 voyageur Exp $

inherit gnome2

DESCRIPTION="A library providing GLib serialization and deserialization support for the JSON format"
HOMEPAGE="http://live.gnome.org/JsonGlib"
SRC_URI="http://folks.o-hand.com/~ebassi/sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.15"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS README"
