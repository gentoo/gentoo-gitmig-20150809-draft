# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/duali/duali-0.1.1.ebuild,v 1.2 2004/02/22 20:02:16 agriffis Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Arabic dictionary based on the DICT protocol"
HOMEPAGE="http://www.arabeyes.org/project.php?proj=Duali"
SRC_URI="mirror://sourceforge/arabeyes/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64 ~ia64 ~ppc ~sparc ~alpha ~hppa ~mips"

DEPEND="dev-lang/python"
PDEPEND="app-dicts/duali-data"

src_compile() {
	einfo "just scripts, nothing to compile"
}

src_install() {
	into /usr
	dobin duali dict2db trans2arabic
	insinto /etc
	doins duali.conf
	doman doc/man/*

	insinto /usr/lib/python2.2/site-packages/pyduali
	doins pyduali/*.py

	dodoc README CHANGELOG INSTALL MANIFEST
}
