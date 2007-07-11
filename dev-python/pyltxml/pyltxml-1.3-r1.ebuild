# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyltxml/pyltxml-1.3-r1.ebuild,v 1.5 2007/07/11 06:19:47 mr_bones_ Exp $

inherit distutils

S="${WORKDIR}/PyLTXML-${PV}"
DESCRIPTION="Bindings for LTXML libraries"
HOMEPAGE="http://www.ltg.ed.ac.uk/software/xml/"
SRC_URI=ftp://ftp.cogsci.ed.ac.uk/pub/LTXML/PyLTXML-${PV}.tar.gz
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND=">=dev-lang/python-2.2.2
	=dev-libs/ltxml-1.2.5"
DOCS="00README"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e s':projects/ltg/projects/lcontrib/include:usr/include:' \
		-e s':projects/ltg/projects/lcontrib/lib:usr/lib/ltxml12:' \
		setup.py \
		|| die "sed failed on setup.py"
}
