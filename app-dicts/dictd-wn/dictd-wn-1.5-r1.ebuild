# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dictd-wn/dictd-wn-1.5-r1.ebuild,v 1.3 2003/01/19 16:29:01 doctomoe Exp $

MY_P=${P/td/t}-pre
S=${WORKDIR}
DESCRIPTION="WordNet for dict"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"
HOMEPAGE="http://www.dict.org"

DEPEND=">=app-text/dictd-1.5.5"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc "

src_install () {
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins wn.dict.dz
	doins wn.index
}

# vim: ai et sw=4 ts=4
