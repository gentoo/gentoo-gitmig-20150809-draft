# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/signify/signify-1.07.ebuild,v 1.4 2002/07/17 05:26:37 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A (semi-)random e-mail signature rotator"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/text/${P}.tar.gz"

DEPEND="sys-devel/perl"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

src_compile() {						   
   echo "Perl script!  Woohoo!  No need to compile!"
}

src_install() {							   
	make PREFIX=${D}/usr/ MANDIR=${D}/usr/share/man install || die
	dodoc COPYING README signify.txt signify.lsm
	docinto examples
	cd examples
	dodoc Columned Complex Simple SimpleOrColumned

}
