# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-de/ispell-de-20011124.ebuild,v 1.1 2002/12/03 07:15:39 seemant Exp $

MY_P=igerman98-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="German and Swiss dictionaries for ispell"
SRC_URI="http://lisa.goe.net/~bjacke/igerman98/dict/${MY_P}.tar.bz2"
HOMEPAGE="http://lisa.goe.net/~bjacke/igerman98/dict"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="app-text/ispell"

src_compile() {

	make || die

	make \
		german.hash swiss || die

}

src_install () {
	
	make \
		DESTDIR=${D} \
		install swiss-install || die
	
	insinto /usr/lib/ispell
	doins german.aff german.hash
 
	dodoc Documentation/*

}
