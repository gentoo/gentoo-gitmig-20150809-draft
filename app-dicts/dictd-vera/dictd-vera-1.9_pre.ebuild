# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dictd-vera/dictd-vera-1.9_pre.ebuild,v 1.1 2004/01/16 00:09:18 liquidx Exp $

MY_P=dict-vera-${PV/_/-}
DESCRIPTION="V.E.R.A. -- Virtual Entity of Relevant Acronyms for dict"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"
HOMEPAGE="http://www.dict.org"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND=">=app-text/dictd-1.5.5"

S=${WORKDIR}

src_install () {
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins vera.dict.dz
	doins vera.index
}
