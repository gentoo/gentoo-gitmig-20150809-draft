# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmathview-bonobo/gtkmathview-bonobo-0.0.2.ebuild,v 1.1 2004/01/23 03:30:33 matsuu Exp $

inherit gnome2

DESCRIPTION="Bonobo wrapper for GtkMathView"
HOMEPAGE="http://helm.cs.unibo.it/gtkmathview-bonobo/"
SRC_URI="http://helm.cs.unibo.it/gtkmathview-bonobo/sources/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtkmathview-0.5.1
	>=gnome-base/libbonoboui-2.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"
