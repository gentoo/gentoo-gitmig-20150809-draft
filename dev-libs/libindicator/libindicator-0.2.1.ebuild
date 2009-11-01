# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicator/libindicator-0.2.1.ebuild,v 1.1 2009/11/01 16:00:05 mrpouet Exp $

GCONF_DEBUG=no
inherit gnome2

DESCRIPTION="A set of symbols and convience functions that all indicators would like to use"
HOMEPAGE="http://launchpad.net/libindicator/"
SRC_URI="http://launchpad.net/${PN}/0.2/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="!<gnome-extra/indicator-applet-0.2"
DEPEND="${RDEPEND}"

pkg_setup() {
	DOCS="AUTHORS"
	G2CONF="--disable-dependency-tracking"
}
