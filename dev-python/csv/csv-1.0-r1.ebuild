# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/csv/csv-1.0-r1.ebuild,v 1.1 2004/02/14 15:44:27 liquidx Exp $

inherit distutils

DESCRIPTION="CSV Module for Python"
HOMEPAGE="http://www.object-craft.com.au/projects/csv/"
SRC_URI="http://www.object-craft.com.au/projects/csv/download/${P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"
IUSE=""

pkg_setup() {
	einfo "This package is installed as csv2.py to avoid conflict with"
	einfo "python-2.3.x"
}

src_unpack() {
	unpack ${A}
	# patch thanks to David Grant <david.grant@telus.net> (#40429)
	cd ${S}; epatch ${FILESDIR}/${P}-rename.patch
}
	
