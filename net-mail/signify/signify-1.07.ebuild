# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/signify/signify-1.07.ebuild,v 1.3 2002/07/11 06:30:47 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${PN}
DESCRIPTION="A (semi-)random e-mail signature rotator"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/text/${A}"

DEPEND="virtual/glibc
	 >=sys-devel/perl-5"

src_compile() {                           
   echo "Perl script!  Woohoo!  No need to compile!"
}

src_install() {                               
    try make install PREFIX=${D}/usr/ MANDIR=${D}/usr/share/man
    dodoc COPYING README signify.txt signify.lsm
    docinto examples
    cd examples
    dodoc Columned Complex Simple SimpleOrColumned

}

