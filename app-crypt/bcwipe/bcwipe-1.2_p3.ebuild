# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bcwipe/bcwipe-1.2_p3.ebuild,v 1.4 2004/03/06 04:46:45 vapier Exp $

DESCRIPTION="BCWipe secure file removal utility"
HOMEPAGE="http://www.jetico.com/"
SRC_URI="http://www.jetico.com/linux/BCWipe-${PV/_p/-}.tar.gz"

LICENSE="bestcrypt"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"
RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "Make failed"
}

src_install() {
	dobin bcwipe || die
	doman bcwipe.1
}
