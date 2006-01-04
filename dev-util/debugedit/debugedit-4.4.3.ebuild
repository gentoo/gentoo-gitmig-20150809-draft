# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debugedit/debugedit-4.4.3.ebuild,v 1.1 2006/01/04 03:04:48 tester Exp $

DESCRIPTION="Standalone debugedit taken from rpm"

HOMEPAGE="http://www.rpm.org/"
SRC_URI="http://dev.gentoo.org/~tester/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/popt
	dev-libs/elfutils"
#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin debugedit
}
