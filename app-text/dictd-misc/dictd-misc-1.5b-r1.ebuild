# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd-misc/dictd-misc-1.5b-r1.ebuild,v 1.3 2002/07/31 17:57:14 kabau Exp $

MY_P=${P/dictd/dict}-pre
S=${WORKDIR}
DESCRIPTION=""
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"
HOMEPAGE="http://www.dict.org"

DEPEND=">=app-text/dictd-1.5.5"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_install () {
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins easton.dict.dz
	doins easton.index
	doins hitchcock.dict.dz
	doins hitchcock.index
	doins world95.dict.dz
	doins world95.index
}

# vim: ai et sw=4 ts=4
