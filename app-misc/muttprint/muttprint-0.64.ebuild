# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/muttprint/muttprint-0.64.ebuild,v 1.1 2003/04/18 17:34:10 latexer Exp $

DESCRIPTION="pretty printing of your mails"
HOMEPAGE="http://muttprint.sf.net/"
SRC_URI="mirror://sourceforge/muttprint/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="app-text/tetex"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile ${T}/Makefile
	sed -e "s:(docdir)/muttprint:(docdir)/muttprint-${PV}:" \
		${T}/Makefile > Makefile
	
	#here comes some ugly hacks to install the docs in the right spot
	for lang in de en es it; do
		cd ${S}/doc/manual/$lang
		mv Makefile ${T}/Makefile-$lang
		sed -e "s:(docdir)/muttprint:(docdir)/muttprint-${PV}:" \
			${T}/Makefile-$lang > Makefile
		cd ${S}
	done

}

src_install() {
	# understanding the install part of the Makefiles.
	make prefix=${D}/usr docdir=${D}/usr/share/doc/ install || die
}
