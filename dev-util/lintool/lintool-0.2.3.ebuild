# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lintool/lintool-0.2.3.ebuild,v 1.5 2002/12/09 04:21:15 manson Exp $

DESCRIPTION="Gentoo Linux \"lint\" utility"
HOMEPAGE="http://www.gentoo.org/~karltk/projects/lintool/"
SRC_URI="http://www.gentoo.org/~karltk/projects/lintool/releases/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc "
DEPEND=">=dev-lang/python-2.2"
S="${WORKDIR}/${P}"

src_compile() {
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README NEWS ChangeLog COPYING AUTHORS
}
