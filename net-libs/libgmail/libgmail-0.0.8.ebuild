# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libgmail/libgmail-0.0.8.ebuild,v 1.4 2005/02/02 16:26:31 squinky86 Exp $

inherit python

DESCRIPTION="Python bindings to access Google's gmail service"
HOMEPAGE="http://libgmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/libgmail/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE=""

DEPEND=">=sys-apps/sed-4"

RDEPEND="dev-python/logging
	virtual/python"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:import sys:import logging\nimport sys:g' demos/gmailpopd.py
}

src_install() {
	python_version
	exeinto /usr/lib/python${PYVER}/site-packages
	doexe libgmail.py constants.py mkconstants.py
	exeinto /usr/share/doc/${PF}/demos
	doexe -r demos/*
	dodoc ANNOUNCE CHANGELOG README
}
