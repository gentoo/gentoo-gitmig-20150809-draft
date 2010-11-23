# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-gui/foomatic-gui-0.7.9.4.ebuild,v 1.1 2010/11/23 10:39:30 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="GNOME interface for configuring the Foomatic printer filter system"
HOMEPAGE="http://freshmeat.net/projects/foomatic-gui/"
SRC_URI="mirror://debian/pool/main/f/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="
	>=dev-python/gnome-python-extras-2.10.0
	dev-python/ipy
	dev-python/pygtk
	dev-python/pywebkitgtk
	>=dev-python/pyxml-0.8
	net-print/foomatic-db-engine"

S="${WORKDIR}/${PN}"

PYTHON_MODNAME="foomatic"
