# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsps/cvsps-2.0_rc1.ebuild,v 1.1 2003/06/30 22:22:31 seemant Exp $

IUSE=""

MY_P=${P/_/}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Generates patchset information from a CVS repository"
HOMEPAGE="http://www.cobite.com/cvsps/"
SRC_URI="http://www.cobite.com/cvsps/${MY_P}.tar.gz" 

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

DEPEND=""

src_compile() {
	emake || die
}

src_install() {
	into /usr
	dobin cvsps
	doman cvsps.1
	dodoc README CHANGELOG COPYING
}
