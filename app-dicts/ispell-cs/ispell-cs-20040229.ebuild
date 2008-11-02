# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-cs/ispell-cs-20040229.ebuild,v 1.5 2008/11/02 19:26:22 welp Exp $

inherit multilib

MY_P=${PN/cs/czech}
DESCRIPTION="The Czech dictionary for ispell"
HOMEPAGE="ftp://ftp.tul.cz/pub/unix/ispell/"
SRC_URI="ftp://ftp.tul.cz/pub/unix/ispell/${MY_P}-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="alpha ~amd64 hppa ~mips ppc sparc x86"

DEPEND="dev-lang/perl
	app-text/ispell"

S=${WORKDIR}/${MY_P}

src_compile() {
	make all || die
}

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins czech.aff czech.hash || die
	dodoc README
}
