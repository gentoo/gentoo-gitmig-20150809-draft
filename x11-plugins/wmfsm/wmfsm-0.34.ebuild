# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfsm/wmfsm-0.34.ebuild,v 1.1 2002/10/03 16:14:24 raker Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="dockapp for monitoring filesystem usage"
HOMEPAGE="http://www.cs.mcgill.ca/~cgray4/"
SRC_URI="http://www.cs.mcgill.ca/~cgray4/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"
RDEPEND="${DEPEND}"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

}
