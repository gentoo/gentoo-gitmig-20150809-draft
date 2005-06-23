# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.6.2-r1.ebuild,v 1.6 2005/06/23 02:09:22 agriffis Exp $

inherit gnome2

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ~sparc x86"
IUSE="doc static"
RESTRICT="test"

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

DOCS="AUTHORS ChangeLog NEWS README TODO"

G2CONF="${G2CONF} $(use_enable static)"
