# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyXML-py21/PyXML-py21-0.8.1.ebuild,v 1.3 2003/06/21 22:30:23 drobbins Exp $

PYTHON_SLOT_VERSION=2.1

inherit distutils
P_NEW="${PN%-py21}-${PV}"
S="${WORKDIR}/${P_NEW}"

DESCRIPTION="A collection of libraries to process XML with Python."
SRC_URI="mirror://sourceforge/pyxml/${P_NEW}.tar.gz"
HOMEPAGE="http://pyxml.sourceforge.net/"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"
LICENSE="PYTHON"
IUSE=""

src_install() 
{
	mydoc="ANNOUNCE CREDITS PKG-INFO doc/*.tex"
	distutils_src_install
	dohtml -r doc/*
}
