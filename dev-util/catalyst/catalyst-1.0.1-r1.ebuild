# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catalyst/catalyst-1.0.1-r1.ebuild,v 1.1 2004/02/19 21:04:37 zhen Exp $

DESCRIPTION="Gentoo Linux official release metatool"
HOMEPAGE="http://www.gentoo.org/proj/en/releng/catalyst"
SRC_URI="http://dev.gentoo.org/~zhen/catalyst/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~alpha ~mips"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/python
		sys-apps/portage"

S=${WORKDIR}/${PN}

src_install() {

	dodir /usr/lib/${PN}
	dodir /usr/lib/${PN}/modules
	insinto /usr/lib/${PN}/modules
	doins modules/*
	dodir /usr/lib/${PN}/targets
	for x in arch targets/*
	do
		dodir /usr/lib/${PN}/$x
		install  $x/* -m 0755 ${D}/usr/lib/${PN}/$x
	done
	dodir /usr/bin
	dosym /usr/bin/catalyst /usr/lib/${PN}/catalyst
	insinto /usr/lib/${PN}
	doins sparc64-isogen.sh x86-isogen.sh
	insopts -m0755
	doins catalyst
	DOCDESTTREE="." dohtml -A spec,amd64 -r kconfig examples
	dodoc TODO README ChangeLog ChangeLog.old AUTHORS COPYING REMARKS
	insinto /etc
	insopts -m0644
	doins files/catalyst.conf
}
