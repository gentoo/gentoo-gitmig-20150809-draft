# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pigz/pigz-2.1.5-r1.ebuild,v 1.2 2010/01/01 19:38:05 fauli Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A parallel implementation of gzip"
HOMEPAGE="http://www.zlib.net/pigz/"
SRC_URI="http://www.zlib.net/pigz/${P}.tar.gz"

LICENSE="PIGZ"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~amd64-linux ~sparc64-solaris"
IUSE="symlink test"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	test? ( app-arch/ncompress )"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-respect-flags.patch
	epatch "${FILESDIR}"/${P}-decode-symlinks-to-stdout.patch
	epatch "${FILESDIR}"/${P}-gunzip-compat.patch
}

src_compile() {
	tc-export CC
	emake || die "make failed"
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
