# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lintool/lintool-0.2.3-r1.ebuild,v 1.2 2003/03/29 11:32:44 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gentoo Linux \"lint\" utility"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/lintool-copyright-patch.diff"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc hppa alpha"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=dev-lang/python-2.2"

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
