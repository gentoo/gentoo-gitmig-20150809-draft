# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-gui/foomatic-gui-0.6.7.ebuild,v 1.1 2004/08/04 15:35:39 lanius Exp $

inherit distutils

DESCRIPTION="GNOME interface for configuring the Foomatic printer filter system"
HOMEPAGE="http://freshmeat.net/projects/foomatic-gui/"
SRC_URI="mirror://debian/pool/main/f/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT=0
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${PN}

RDEPEND=">=dev-lang/python-2.2.0
	>=dev-python/gnome-python-2.0.0
	>=net-print/foomatic-2.0.2
	>=dev-python/pyxml-0.8
	app-text/ghostscript"
