# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/djb/djb-0.5.2.ebuild,v 1.7 2009/09/23 17:18:13 patrick Exp $

inherit toolchain-funcs fixheadtails

DESCRIPTION="library created from code by Dan Bernstein"
HOMEPAGE="http://www.fefe.de/djb/"
SRC_URI="http://www.fefe.de/djb/djb-${PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	ht_fix_file */Makefile.static
	for cc in */conf-cc ; do echo "$(tc-getCC) ${CFLAGS}" > ${cc} ; done
	for ld in */conf-ld ; do echo "$(tc-getCC) ${LDFLAGS}" > ${ld} ; done
}

src_compile() {
	emake || die
}

src_install() {
	for lib in */*.a ; do
		newlib.a ${lib} libdjb-$(basename ${lib}) || die "newlib failed"
	done
	for man in */*.3 ; do
		newman ${man} ${PN}-$(basename ${man})
	done
	exeinto /usr/lib/${PN}
	doexe *.pl || die "doexe .pl failed"
	dodoc CHANGES TODO
}
