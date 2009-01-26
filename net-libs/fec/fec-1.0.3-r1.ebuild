# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/fec/fec-1.0.3-r1.ebuild,v 1.1 2009/01/26 00:33:37 tommy Exp $

inherit eutils flag-o-matic java-pkg-2 toolchain-funcs

DESCRIPTION="Forward error correction libs"
HOMEPAGE="http://www.onionnetworks.com/developers/"
SRC_URI="http://www.onionnetworks.com/downloads/${P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"
S=${WORKDIR}/${P}/src/csrc/

src_compile() {
	append-flags -fPIC
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" || die
}

src_install() {
	dolib.so ../../lib/fec-linux-x86/lib/linux/x86/libfec{8,16}.so || die
}
