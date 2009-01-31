# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-levenshtein/python-levenshtein-0.10.ebuild,v 1.5 2009/01/31 23:46:59 patrick Exp $

inherit distutils

MY_P=${P/l/L}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Levenshtein contains functions for fast computation of Levenshtein (edit) distance, and edit operations"
SRC_URI="http://trific.ath.cx/Ftp//python/levenshtein/${MY_P}.tar.bz2"
HOMEPAGE="http://trific.ath.cx/resources/python/levenshtein/"
IUSE="doc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"

DEPEND="virtual/python"

src_unpack(){
	unpack ${A}
	use doc && ( cp ${FILESDIR}/genextdoc.py ${T}
		chmod +x ${T}/genextdoc.py )
}

src_install(){
	distutils_src_install
	use doc && ( ${T}/genextdoc.py Levenshtein
		dohtml Levenshtein.html )
}
