# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hspell/hspell-0.6.ebuild,v 1.8 2004/09/27 19:59:20 gustavoz Exp $

DESCRIPTION="A Hebrew spell checker"
HOMEPAGE="http://www.ivrix.org.il/projects/spell-checker/"
SRC_URI="http://ivrix.org.il/projects/spell-checker/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 sparc"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1"

src_compile() {
	mv Makefile Makefile.orig
	sed -e "s:/usr/local:/usr:" Makefile.orig > Makefile

	#emake b0rks build :/
	make || die
}

src_install() {
	#einstall b0rks install :/
	make DESTDIR=${D} install || die
	dodoc README TODO WHANTSNEW
}
