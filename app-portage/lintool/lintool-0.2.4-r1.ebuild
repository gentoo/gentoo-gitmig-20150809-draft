# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/lintool/lintool-0.2.4-r1.ebuild,v 1.2 2003/11/14 16:34:18 plasmaroo Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Gentoo Linux \"lint\" utility"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~alpha"

DEPEND=">=dev-lang/python-2.2"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/lintool-0.2.4-fixyear.diff
}

src_compile() {
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog COPYING AUTHORS
}
