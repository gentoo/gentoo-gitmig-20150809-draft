# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/wml/wml-2.0.9.ebuild,v 1.5 2003/03/11 21:11:45 seemant Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Website META Language"
SRC_URI="http://www.engelschall.com/sw/wml/distrib/${P}.tar.gz"
HOMEPAGE="http://www.engelschall.com/sw/wml/"
DEPEND=">=dev-lang/perl-5.6.1-r3"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc "
SLOT="0"

src_compile() {
	# 2002-11-11: karltk@gentoo.org
	# It barfs if CFLAGS is set. Dunno why.
	# It'll default to -O2, which is probably safest.
	unset CFLAGS
	unset CC
#	econf || die "./configure failed"
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die "./configure failed"
	emake || die
}

src_install () {
	einstall || die
	dodoc ANNOUNCE BUGREPORT C* INSTALL MANIFEST README* SUPPORT VERSION*
}
