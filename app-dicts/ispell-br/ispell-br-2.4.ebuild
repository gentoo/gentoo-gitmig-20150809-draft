# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-br/ispell-br-2.4.ebuild,v 1.1 2002/12/03 07:15:39 seemant Exp $

MY_P="br.ispell-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Brazilian portuguese dictionary for ispell"
HOMEPAGE="http://www.ime.usp.br/~ueda/br.ispell"
SRC_URI="http://www.ime.usp.br/~ueda/br.ispell/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="app-text/ispell
	sys-apps/gawk"

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
