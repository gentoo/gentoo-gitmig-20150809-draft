# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymetar/pymetar-0.12.ebuild,v 1.1 2004/09/04 23:04:02 lucass Exp $

inherit distutils

HOMEPAGE="http://www.schwarzvogel.de/software-pymetar.shtml"
DESCRIPTION="PyMETAR downloads the weather report for a given station ID, decodes it and the provides easy access to all the data found in the report."
SRC_URI="http://www.schwarzvogel.de/pkgs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/python"
DOCS="librarydoc.txt THANKS TODO bin/example.py README"
