# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/lintool/lintool-0.2.3-r1.ebuild,v 1.2 2004/01/23 00:31:24 liquidx Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gentoo Linux \"lint\" utility"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/lintool-copyright-patch.diff"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc hppa alpha mips"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=dev-lang/python-2.2"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/lintool-copyright-patch.diff
	epatch ${FILESDIR}/lintool-0.2.4-python.diff
}
src_compile() {
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README NEWS ChangeLog COPYING AUTHORS
}
