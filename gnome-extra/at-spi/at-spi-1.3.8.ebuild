# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.3.8.ebuild,v 1.3 2004/01/07 18:38:57 gustavoz Exp $

IUSE="doc"

inherit gnome2

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc ~alpha ~amd64 ~sparc"

RDEPEND=">=gnome-base/gail-1.3
	>=gnome-base/libbonobo-1.107
	>=dev-libs/atk-1.3.4
	>=x11-libs/gtk+-2
	>=dev-libs/popt-1.6.3
	gnome-base/ORBit2
	virtual/x11"
# virtual/x11 for libXtst libXi libXkb

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( dev-util/gtk-doc )"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="AUTHORS ChangeLog COPYING NEWS README TODO"
