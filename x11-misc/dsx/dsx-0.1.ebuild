# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dsx/dsx-0.1.ebuild,v 1.2 2004/04/11 15:01:08 pyrania Exp $

DESCRIPTION="dsx - command line selection of your X desktop environment"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86"

IUSE=""
DEPEND=""
RDEPEND="x11-base/xfree
>=dev-lang/python-2.1"

src_install() {
	exeinto /usr/bin
	newexe ${FILESDIR}/${P} dsx
}
