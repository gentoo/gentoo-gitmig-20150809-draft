# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/phlib/phlib-1.20.ebuild,v 1.1 2004/04/02 20:45:26 scandium Exp $

DESCRIPTION="phlib is a collection of support functions and classes used by Goldwater and the DGEE"
HOMEPAGE="http://www.nfluid.com/"
SRC_URI="http://www.nfluid.com/download/src/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	sed -i s/cflags/CFLAGS/ ${S}/configure
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
