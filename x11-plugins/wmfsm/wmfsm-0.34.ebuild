# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfsm/wmfsm-0.34.ebuild,v 1.7 2004/04/30 22:44:14 pvdabeel Exp $

IUSE=""
DESCRIPTION="dockapp for monitoring filesystem usage"
HOMEPAGE="http://www.cs.mcgill.ca/~cgray4/"
SRC_URI="http://www.cs.mcgill.ca/~cgray4/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc amd64 ppc"

DEPEND="virtual/x11"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

}
