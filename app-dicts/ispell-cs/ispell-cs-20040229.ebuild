# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-cs/ispell-cs-20040229.ebuild,v 1.2 2008/09/15 13:30:33 pva Exp $

MY_P=${PN/cs/czech}
DESCRIPTION="The Czech dictionary for ispell"
HOMEPAGE="ftp://ftp.tul.cz/pub/unix/ispell/"
SRC_URI="ftp://ftp.tul.cz/pub/unix/ispell/${MY_P}-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="ppc x86 sparc alpha mips hppa"

DEPEND="dev-lang/perl
	app-text/ispell"

S=${WORKDIR}/${MY_P}

src_compile() {
	make all || die
}

src_install () {
	insinto /usr/lib/ispell
	doins czech.aff czech.hash
	dodoc README
}
