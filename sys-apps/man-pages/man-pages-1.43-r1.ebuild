# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man-pages/man-pages-1.43-r1.ebuild,v 1.2 2001/12/27 05:05:12 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A somewhat comprehensive collection of Linux man pages"

SRC_URI="ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/manpages/man-pages-1.43.tar.gz"

# Modern netman versions are part of the standard man-pages for Linux
#	 ftp://ftp.suse.com/pub/people/ak/netman/netman-20000610.tgz"

RDEPEND="sys-apps/man"


src_unpack() {

	unpack ${P}.tar.gz
    
	cd ${S}
#	unpack netman-20000610.tgz
	tar xzf ${FILESDIR}/man2.tar.gz
    
#	for x in 2 3 7
#	do
#		mv netman/*.$x man$x
#	done

}

src_install() {

	for x in 1 2 3 4 5 6 7 8
	do
		doman man$x/*.[1-9]
	done
	
	dodoc man-pages-*.Announce README
	docinto netman
#	dodoc netman/FIXME netman/README
}








