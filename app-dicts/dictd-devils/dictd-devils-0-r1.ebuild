# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dictd-devils/dictd-devils-0-r1.ebuild,v 1.4 2003/02/13 06:25:54 vapier Exp $

MY_P=devils-dict-pre
S=${WORKDIR}
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"
HOMEPAGE="http://www.dict.org"
DESCRIPTION="The Devil's Dictionary for dict"

DEPEND=">=app-text/dictd-1.5.5"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc "

src_install () {
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins devils.dict.dz
	doins devils.index
}

# vim: ai et sw=4 ts=4
