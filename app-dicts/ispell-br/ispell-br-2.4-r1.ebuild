# Copyright 2002-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-br/ispell-br-2.4-r1.ebuild,v 1.2 2003/02/12 13:22:15 seemant Exp $

inherit eutils

MY_P="br.ispell-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Brazilian portuguese dictionary for ispell"
HOMEPAGE="http://www.ime.usp.br/~ueda/br.ispell"
SRC_URI="http://www.ime.usp.br/~ueda/br.ispell/${MY_P}.tar.gz
	mirror://gentoo/${P}-palavras-gentoo.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="app-text/ispell
	sys-apps/gawk"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-palavras-gentoo.diff
}

src_compile() {
	emake VDIR=/usr/share/dict || die
	make palavras
	make paradigmas
}

src_install () {
	emake \
		prefix=${D}usr \
		VDIR=${D}/usr/share/dict \
		HASHDIR=${D}usr/lib/ispell \
		MANDIR=${D}usr/share/man \
		install || die
	
	dodoc COPYING README
}
