# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/lightblue/lightblue-0.4.ebuild,v 1.1 2009/06/03 00:01:41 deathwing00 Exp $

inherit distutils

DESCRIPTION="LightBlue is a cross-platform Bluetooth API for Python that
provides simple access to Bluetooth ops."
HOMEPAGE="http://lightblue.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.3
>=dev-python/pybluez-0.9
>=dev-libs/openobex-1.3"
RDEPEND="${DEPEND}"

