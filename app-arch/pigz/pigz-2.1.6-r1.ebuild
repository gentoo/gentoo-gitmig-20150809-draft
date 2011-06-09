# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pigz/pigz-2.1.6-r1.ebuild,v 1.4 2011/06/09 03:27:02 mattst88 Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="A parallel implementation of gzip"
HOMEPAGE="http://www.zlib.net/pigz/"
SRC_URI="http://www.zlib.net/pigz/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~sparc ~x86 ~amd64-linux ~sparc64-solaris"
IUSE="symlink test"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	test? ( app-arch/ncompress )"

src_prepare() {
	sed -i -e '/^CFLAGS=/ d' -e '4s/cc/$(CC) $(LDFLAGS)/' "${S}/Makefile" || die
	epatch "${FILESDIR}/${P}-doubledash.patch"
	tc-export CC
}

src_install() {
	dobin ${PN} || die "Failed to install"
	dosym /usr/bin/${PN} /usr/bin/un${PN} || die
	dodoc README || die
	doman ${PN}.1 || die

	if use symlink; then
		dosym /usr/bin/${PN} /usr/bin/gzip || die
		dosym /usr/bin/un${PN} /usr/bin/gunzip || die
	fi
}
