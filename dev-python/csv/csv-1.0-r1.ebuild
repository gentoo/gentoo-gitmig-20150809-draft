# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/csv/csv-1.0-r1.ebuild,v 1.12 2007/03/05 02:41:59 genone Exp $

inherit distutils eutils

DESCRIPTION="CSV Module for Python"
HOMEPAGE="http://www.object-craft.com.au/projects/csv/"
SRC_URI="http://www.object-craft.com.au/projects/csv/download/${P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="alpha ia64 ~ppc ppc64 ~sparc x86"
IUSE=""

pkg_setup() {
	elog "This package is installed as csv2.py to avoid conflict with"
	elog "python-2.3.x"
}

src_unpack() {
	unpack ${A}
	# patch thanks to David Grant <david.grant@telus.net> (#40429)
	cd ${S}
	epatch ${FILESDIR}/${P}-rename.patch
}
