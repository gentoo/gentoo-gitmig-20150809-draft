# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tprint/tprint-1.1.0.ebuild,v 1.2 2004/08/30 23:38:51 dholm Exp $

DESCRIPTION="Transparent Print Utility for terminals"
HOMEPAGE="http://sourceforge.net/projects/tprint/"
SRC_URI="mirror://sourceforge/tprint/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
		>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e "s:-g -O2 -Wall:${CFLAGS}:g" \
	Makefile || die "Error parsing Makefile"
}

src_compile() {
	emake || die "failed during compiling..."
}

src_install() {
	dodir /etc/tprint
	insinto /etc/tprint
	doins tprint.conf
	exeinto /usr/bin
	doexe tprint

	dodoc INSTALL README
}
