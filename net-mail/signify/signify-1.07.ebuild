# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/signify/signify-1.07.ebuild,v 1.9 2002/10/04 06:09:33 vapier Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A (semi-)random e-mail signature rotator"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/text/${P}.tar.gz"
HOMEPAGE="http://ibiblio.org/pub/Linux/utils/text/"

DEPEND="sys-devel/perl"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 sparc sparc64 ppc"

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
