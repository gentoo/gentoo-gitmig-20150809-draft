# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-gui/foomatic-gui-0.7.9.2.ebuild,v 1.1 2010/05/17 20:10:49 jlec Exp $

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="*"
PYTHON_MODNAME="foomatic"

inherit distutils

DESCRIPTION="GNOME interface for configuring the Foomatic printer filter system"
HOMEPAGE="http://freshmeat.net/projects/foomatic-gui/"
SRC_URI="mirror://debian/pool/main/f/${PN}/${PN}_${PV}+nmu2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="
	dev-python/ipy
	>=dev-python/gnome-python-extras-2.10.0
	>=dev-python/pyxml-0.8
	net-print/foomatic-db-engine"

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}"/${P}+nmu2
