# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygoogle/pygoogle-0.5.2.ebuild,v 1.8 2004/11/04 16:45:25 pythonhead Exp $

inherit distutils

S=${WORKDIR}/${PN}
DESCRIPTION="A Python wrapper for the Google web API"
SRC_URI="http://diveintomark.org/projects/${PN}/${P}.zip"
HOMEPAGE="http://diveintomark.org/projects/pygoogle/"

IUSE=""
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="x86"

DEPEND="virtual/python
	app-arch/unzip"
