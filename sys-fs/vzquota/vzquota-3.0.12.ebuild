# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/vzquota/vzquota-3.0.12.ebuild,v 1.2 2008/11/11 10:32:51 pva Exp $

inherit toolchain-funcs

DESCRIPTION="OpenVZ VPS disk quota utility"
HOMEPAGE="http://openvz.org/download/utils/vzquota/"
SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	sed -e 's,$(INSTALL) -s -m,$(INSTALL) -m,' \
		-e 's:$(CC) $(CFLAGS) -o:$(CC) $(CFLAGS) $(LDFLAGS) -o:' \
			-i "${S}/src/Makefile" || die
}

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	keepdir /var/vzquota
}
