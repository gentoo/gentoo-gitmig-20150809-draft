# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd-vera/dictd-vera-1.7-r1.ebuild,v 1.6 2002/10/04 05:04:01 vapier Exp $

MY_P=vera_${PV}
S=${WORKDIR}
DESCRIPTION="V.E.R.A. -- Virtual Entity of Relevant Acronyms for dict"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"
HOMEPAGE="http://www.dict.org"

DEPEND=">=app-text/dictd-1.5.5"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_install () {
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins vera.dict
	doins vera.index
}

# vim: ai et sw=4 ts=4
