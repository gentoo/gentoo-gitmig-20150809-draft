# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achime Gottinger <achim@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ispell-de/ispell-de-20011124.ebuild,v 1.3 2002/04/27 05:11:16 seemant Exp $

MY_P=igerman98-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="German and Swiss dictionaries for ispell"
SRC_URI="http://lisa.goe.net/~bjacke/igerman98/dict/${MY_P}.tar.bz2"
HOMEPAGE="http://lisa.goe.net/~bjacke/igerman98/dict"

DEPEND="app-text/ispell"

src_compile() {

	make || die

	make \
		SQ=`pwd`/bin/sq.pl \
		UNSQ=`pwd`/bin/unsq.pl \
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
