# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.6.0.ebuild,v 1.4 2004/11/12 03:19:17 gustavoz Exp $

inherit gnome2

RESTRICT="maketest"

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"
LICENSE="LGPL-2"

SLOT="1"
KEYWORDS="x86 ~ppc ~alpha ~amd64 sparc ~hppa ~ia64 ~mips"
IUSE=""

RDEPEND=">=gnome-base/gail-1.3
	>=gnome-base/libbonobo-1.107
	>=dev-libs/atk-1.7.2
	>=x11-libs/gtk+-2
	dev-libs/popt
	>=gnome-base/orbit-2
	virtual/x11"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

#MAKEOPTS="${MAKEOPTS} -j1"

DOCS="AUTHORS ChangeLog NEWS README TODO"
