# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygoogle/pygoogle-0.5.3.ebuild,v 1.2 2004/01/24 21:16:43 liquidx Exp $

inherit distutils

S=${WORKDIR}/${P}
DESCRIPTION="A Python wrapper for the Google web API"
SRC_URI="mirror://sourceforge/pygoogle/${P}.tar.gz"
HOMEPAGE="http://pygoogle.sourceforge.net/"

IUSE=""
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="x86"

DEPEND="virtual/python"
