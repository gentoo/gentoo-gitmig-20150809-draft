# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dictd-vera/dictd-vera-1.7-r1.ebuild,v 1.8 2004/05/31 18:24:58 vapier Exp $

MY_P=vera_${PV}
DESCRIPTION="V.E.R.A. -- Virtual Entity of Relevant Acronyms for dict"
HOMEPAGE="http://www.dict.org/"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=app-text/dictd-1.5.5"

S=${WORKDIR}

src_install() {
	insinto /usr/lib/dict
	doins vera.dict vera.index || die
}
