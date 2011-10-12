# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tardy/tardy-1.17-r1.ebuild,v 1.2 2011/10/12 01:59:02 jer Exp $

inherit eutils

DESCRIPTION="A tar post-processor"
HOMEPAGE="http://tardy.sourceforge.net/"
SRC_URI="mirror://sourceforge/tardy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CFLAGS/d' \
		-e '/^LDFLAGS =/d' \
		-e 's/$(CXX) $(CFLAGS)/$(CXX) $(CXXFLAGS) -o $@/' \
		-e '/mv \(.*\)\.o \(.*\)\/\1\.o/d' \
		-e '/@sleep 1/d' \
		Makefile.in || die
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
}

src_test() {
	make sure || die "test failed"
}

src_install() {
	make RPM_BUILD_ROOT="${D}" install || die "make install failed"
	dodoc README
}
