# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/wml/wml-2.0.8.ebuild,v 1.7 2003/02/13 10:31:59 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Website META Language"
SRC_URI="http://www.engelschall.com/sw/wml/distrib/${P}.tar.gz"
HOMEPAGE="http://www.engelschall.com/sw/wml/"

DEPEND=">=sys-devel/perl-5.6.1-r3"

LICENSE="GPL-2"
KEYWORDS="x86 sparc "
SLOT="0"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	einstall || die

	dodoc ANNOUNCE BUGREPORT C* INSTALL MANIFEST README* SUPPORT VERSION*
}
