# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catalyst/catalyst-1.0.2.ebuild,v 1.2 2004/03/02 04:25:26 vapier Exp $

DESCRIPTION="Gentoo Linux official release metatool"
HOMEPAGE="http://www.gentoo.org/proj/en/releng/catalyst"
SRC_URI="http://dev.gentoo.org/~zhen/catalyst/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~sparc ~ppc ~alpha ~mips"
IUSE="doc"

DEPEND=""
RDEPEND="dev-lang/python
	sys-apps/portage"

S=${WORKDIR}/${PN}

src_install() {
	insinto /usr/lib/${PN}/modules
	doins modules/*
	for d in arch targets/*
	do
		exeinto /usr/lib/${PN}/${d}
		doexe ${d}/*
	done
	insinto /usr/lib/${PN}
	doins sparc64-isogen.sh x86-isogen.sh
	exeinto /usr/lib/${PN}
	doexe catalyst
	dodir /usr/bin
	dosym ../lib/${PN}/catalyst /usr/bin/catalyst
	if use doc
	then
		DOCDESTTREE="." dohtml -A spec,amd64,livecd -r kconfig examples
	fi
	dodoc TODO README ChangeLog ChangeLog.old AUTHORS COPYING REMARKS
	insinto /etc
	doins files/catalyst.conf
}
