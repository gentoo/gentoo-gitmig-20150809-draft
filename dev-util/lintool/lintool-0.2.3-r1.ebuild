# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lintool/lintool-0.2.3-r1.ebuild,v 1.1 2003/02/18 02:10:05 latexer Exp $

inherit eutils

DESCRIPTION="Gentoo Linux \"lint\" utility"
HOMEPAGE="http://www.gentoo.org/~karltk/projects/lintool/"
SRC_URI="http://www.gentoo.org/~karltk/projects/lintool/releases/${P}.tar.bz2
		mirror://gentoo/lintool-copyright-patch.diff"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa alpha"
DEPEND=">=dev-lang/python-2.2"
S="${WORKDIR}/${P}"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/lintool-copyright-patch.diff
}
src_compile() {
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README NEWS ChangeLog COPYING AUTHORS
}
