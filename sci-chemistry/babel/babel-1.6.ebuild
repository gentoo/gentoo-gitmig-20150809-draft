# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/babel/babel-1.6.ebuild,v 1.2 2004/12/24 16:55:54 ribosome Exp $

inherit eutils

DESCRIPTION="Babel is a program to interconvert file formats used in molecular modeling."

SRC_URI="http://smog.com/chem/babel/files/${P}.tar.Z"

HOMEPAGE="http://smog.com/chem/babel/"
KEYWORDS="x86 ppc sparc ~amd64"
SLOT="0"
LICENSE="as-is"
IUSE=""

#Doesn't really seem to depend on anything (?)
DEPEND="!sci-chemistry/openbabel"

src_unpack() {

	unpack ${P}.tar.Z
	cd ${S}
#Patch the Makefile for gentoo-isms
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-gcc32.diff

}

src_compile() {

	emake || die

}

src_install () {

	make DESTDIR=${D}/usr/bin install || die

	insinto /usr/share/${PN}
	doins ${S}/*.lis

	insinto /etc/env.d
	doins ${FILESDIR}/10babel

	dodoc README.1ST

}

