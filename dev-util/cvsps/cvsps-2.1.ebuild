# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsps/cvsps-2.1.ebuild,v 1.6 2006/02/07 20:42:09 blubb Exp $

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Generates patchset information from a CVS repository"
HOMEPAGE="http://www.cobite.com/cvsps/"
SRC_URI="http://www.cobite.com/cvsps/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~mips ~ppc ppc64 ~sparc x86"
IUSE=""

DEPEND=""

src_install() {
	dobin cvsps
	doman cvsps.1
	dodoc README CHANGELOG COPYING
}
