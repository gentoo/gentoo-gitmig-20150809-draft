# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dsx/dsx-0.1.ebuild,v 1.3 2004/05/23 15:23:46 pvdabeel Exp $

DESCRIPTION="dsx - command line selection of your X desktop environment"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ppc"

IUSE=""
DEPEND=""
RDEPEND="x11-base/xfree
>=dev-lang/python-2.1"

src_install() {
	exeinto /usr/bin
	newexe ${FILESDIR}/${P} dsx
}
