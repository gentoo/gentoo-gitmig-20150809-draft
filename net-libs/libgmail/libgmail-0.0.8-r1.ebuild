# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libgmail/libgmail-0.0.8-r1.ebuild,v 1.1 2005/07/27 19:26:47 vanquirius Exp $

inherit python eutils

DESCRIPTION="Python bindings to access Google's gmail service"
HOMEPAGE="http://libgmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz
	mirror://gentoo/${P}-cvs-20050727.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE=""

DEPEND=">=sys-apps/sed-4"

RDEPEND="dev-python/logging
	virtual/python"

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${WORKDIR}/${P}-cvs-20050727.diff
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
