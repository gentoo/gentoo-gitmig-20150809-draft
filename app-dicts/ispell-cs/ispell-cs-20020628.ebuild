# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-cs/ispell-cs-20020628.ebuild,v 1.4 2003/02/12 13:29:28 seemant Exp $

MY_P=${PN/cs/czech}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Czech dictionary for ispell"
SRC_URI="ftp://ftp.vslib.cz/pub/unix/ispell/${MY_P}-${PV}.tar.gz"
HOMEPAGE="ftp://ftp.vslib.cz/pub/unix/ispell/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ~mips ~hppa"

DEPEND="sys-devel/perl
	app-text/ispell"

src_compile() {
	make all || die
}

src_install () {
	insinto /usr/lib/ispell
	doins czech.aff czech.hash
	dodoc README
}
