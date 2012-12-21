# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/echievements/echievements-1.ebuild,v 1.1 2012/12/21 14:45:29 tommy Exp $

EAPI=5

inherit enlightenment

DESCRIPTION="Show enlightenment echievements"

SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"
LICENSE="LGPL-2.1"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/e_dbus
	media-libs/edje
	x11-wm/enlightenment:0.17="
DEPEND="${RDEPEND}
	virtual/pkgconfig"
