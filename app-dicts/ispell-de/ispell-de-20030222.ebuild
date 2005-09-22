# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-de/ispell-de-20030222.ebuild,v 1.1 2005/09/22 18:48:29 arj Exp $

MY_P=igerman98-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="German and Swiss dictionaries for ispell"
SRC_URI="http://j3e.de/ispell/igerman98/dict/${MY_P}.tar.bz2"
HOMEPAGE="http://j3e.de/ispell/igerman98/"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~ppc ~x86 ~sparc ~alpha ~mips ~hppa ~amd64"

DEPEND="app-text/ispell"

src_compile() {
	make || die "make failed"
	make german.hash || die "make german failed"
	make swiss.hash || die "make swiss failed"
}

src_install () {
	#make DESTDIR=${D} install || die "make german install failed"
	#make DESTDIR=${D} swiss-install || die "make swiss install failed"

	insinto /usr/lib/ispell
	doins german.aff german.hash
	doins swiss.aff swiss.hash

	dodoc Documentation/*
}
