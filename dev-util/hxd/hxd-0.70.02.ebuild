# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/hxd/hxd-0.70.02.ebuild,v 1.2 2009/09/23 17:45:18 patrick Exp $

inherit toolchain-funcs

DESCRIPTION="Binary to hexadecimal converter"
HOMEPAGE="http://www-tet.ee.tu-berlin.de/solyga/linux/"
SRC_URI="http://linux.xulin.de/c/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc ~mips ~ppc"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#Respect FLAGS and avoid stripping
	sed -i -e "/^CFLAGS/s|=|+=|" \
		-e "/^LDFLAGS/s|=|+=|" \
		-e "/^LDFLAGS/s|-s||" \
		-e "s/install -s/install/" \
		Makefile.Linux || die "sed failed"
}

src_compile() {
	econf || die
	emake CC="$(tc-getCC)" -j1 || die "make failed"
}

src_install() {
	dobin hxd unhxd
	doman hxd.1 unhxd.1
	dodoc README TODO
}
