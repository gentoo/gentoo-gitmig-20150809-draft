# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cnetworkmanager/cnetworkmanager-0.21.1.ebuild,v 1.2 2011/04/05 18:08:43 arfrever Exp $

EAPI=3
PYTHON_DEPEND="2:2.5"

inherit distutils

DESCRIPTION="Command line interface for NetworkManager."
HOMEPAGE="http://vidner.net/martin/software/cnetworkmanager/"
SRC_URI="http://vidner.net/martin/software/cnetworkmanager/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/dbus-python-0.80.2
	>=dev-python/pygobject-2.14.0
	>=net-misc/networkmanager-0.7.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PYTHON_MODNAME="dbusclient networkmanager"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
