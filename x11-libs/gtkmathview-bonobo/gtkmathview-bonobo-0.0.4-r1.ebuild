# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmathview-bonobo/gtkmathview-bonobo-0.0.4-r1.ebuild,v 1.2 2012/05/05 03:52:28 jdhore Exp $

EAPI=2
inherit eutils gnome2

DESCRIPTION="Bonobo wrapper for GtkMathView"
HOMEPAGE="http://helm.cs.unibo.it/gtkmathview-bonobo/"
SRC_URI="http://helm.cs.unibo.it/gtkmathview-bonobo/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtkmathview-0.6.2[gtk]
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libgnomeui-2"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.patch"
}
