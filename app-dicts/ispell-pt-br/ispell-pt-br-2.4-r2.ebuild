# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-pt-br/ispell-pt-br-2.4-r2.ebuild,v 1.1 2003/06/13 13:12:56 seemant Exp $

inherit eutils

MY_P="br.ispell-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Brazilian portuguese dictionary for ispell"
HOMEPAGE="http://www.ime.usp.br/~ueda/br.ispell"
SRC_URI="http://www.ime.usp.br/~ueda/br.ispell/${MY_P}.tar.gz
	mirror://gentoo/${P}-palavras-gentoo.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 sparc alpha mips hppa arm"

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
	

	insinto /usr/lib/ispell
	newins br.aff pt_BR.aff
	newins br.hash pt_BR.hash
	rm -f ${D}/usr/lib/ispell/br.*
	
	dodoc COPYING README
}
