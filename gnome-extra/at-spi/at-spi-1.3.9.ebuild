# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.3.9.ebuild,v 1.8 2004/02/10 06:28:44 darkspecter Exp $

inherit gnome2

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc alpha amd64 sparc hppa ia64"
IUSE="doc"

RDEPEND=">=gnome-base/gail-1.3
	>=gnome-base/libbonobo-2
	>=dev-libs/atk-1.3.4
	>=x11-libs/gtk+-2
	dev-libs/popt
	gnome-base/ORBit2
	virtual/x11"
# virtual/x11 for libXtst libXi libXkb

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( dev-util/gtk-doc )
	dev-perl/XML-Parser"

MAKEOPTS="${MAKEOPTS} -j1"

DOCS="AUTHORS ChangeLog COPYING NEWS README TODO"
