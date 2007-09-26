# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vmailmgr-tools/vmailmgr-tools-0.2-r1.ebuild,v 1.4 2007/09/26 04:57:07 mrness Exp $

inherit toolchain-funcs eutils fixheadtails

DESCRIPTION="Add-on tools for use with vmailmgr"
HOMEPAGE="http://untroubled.org/vmailmgr-tools/"
SRC_URI="http://untroubled.org/vmailmgr-tools/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="net-mail/vmailmgr"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gcc34.patch"
	epatch "${FILESDIR}/${P}-quota.patch"
	ht_fix_file "${S}/Makefile"
}

src_compile() {
	echo "${D}/usr/bin" > conf-bin
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin
	./installer || die "install failed"

	doman *.1
	dodoc ANNOUNCEMENT NEWS README VERSION
}
