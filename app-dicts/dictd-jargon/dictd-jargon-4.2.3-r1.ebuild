# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dictd-jargon/dictd-jargon-4.2.3-r1.ebuild,v 1.8 2004/03/06 05:16:59 vapier Exp $

MY_P=${PN/dictd-/}_${PV}
DESCRIPTION="Jargon lexicon"
HOMEPAGE="http://www.dict.org/"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64"

DEPEND=">=app-text/dictd-1.5.5"

S=${WORKDIR}

src_install () {
	dodoc README
	insinto /usr/lib/dict
	doins jargon.dict.dz jargon.index || die
}
