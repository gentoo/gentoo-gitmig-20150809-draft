# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-cs/ispell-cs-20020628.ebuild,v 1.7 2003/08/05 18:11:29 vapier Exp $

MY_P=${PN/cs/czech}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Czech dictionary for ispell"
SRC_URI="ftp://ftp.vslib.cz/pub/unix/ispell/${MY_P}-${PV}.tar.gz"
HOMEPAGE="ftp://ftp.vslib.cz/pub/unix/ispell/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86 sparc alpha mips hppa arm"

DEPEND="dev-lang/perl
	app-text/ispell"

src_compile() {
	make all || die
}

src_install () {
	insinto /usr/lib/ispell
	doins czech.aff czech.hash
	dodoc README
}
