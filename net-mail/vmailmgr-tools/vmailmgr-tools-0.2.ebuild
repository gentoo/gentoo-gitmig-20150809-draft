# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vmailmgr-tools/vmailmgr-tools-0.2.ebuild,v 1.2 2006/03/07 15:22:04 mrness Exp $

inherit toolchain-funcs eutils fixheadtails

DESCRIPTION="Add-on tools for use with vmailmgr"
HOMEPAGE="http://untroubled.org/vmailmgr-tools/"
SRC_URI="http://untroubled.org/vmailmgr-tools/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-mail/vmailmgr"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gcc34.patch"
	ht_fix_file "${S}/Makefile"
}

src_compile() {
	echo "${D}/usr/bin" > conf-bin
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	make || die "make failed"
}

src_install() {
	dodir /usr/bin
	./installer || die "install failed"

	doman *.1
	dodoc ANNOUNCEMENT NEWS README VERSION
}

