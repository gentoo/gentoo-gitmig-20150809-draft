# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-da/ispell-da-1.4.24.ebuild,v 1.1 2003/04/12 14:45:13 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A danish dictionary for ispell"
HOMEPAGE="http://da.speling.org/"
SRC_URI="http://da.speling.org/filer/${P}.tar.gz"

DEPEND="app-text/ispell"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86 sparc alpha mips hppa arm"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/ispell
	doins dansk.aff dansk.hash
 
	dodoc Documentation/*
}
