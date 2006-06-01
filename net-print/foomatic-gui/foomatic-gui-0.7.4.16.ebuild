# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-gui/foomatic-gui-0.7.4.16.ebuild,v 1.3 2006/06/01 05:00:44 weeve Exp $

inherit distutils

DESCRIPTION="GNOME interface for configuring the Foomatic printer filter system"
HOMEPAGE="http://freshmeat.net/projects/foomatic-gui/"
SRC_URI="mirror://debian/pool/main/f/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.2.2
	>=dev-python/gnome-python-extras-2.10.0
	>=net-print/foomatic-2.0.2
	>=dev-python/pyxml-0.8
	virtual/ghostscript
	x11-libs/gksu"
