# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nethogs/nethogs-0.6.1_pre2.ebuild,v 1.3 2008/12/10 22:44:15 maekke Exp $

inherit eutils toolchain-funcs

HOMEPAGE="http://nethogs.sf.net/"
SRC_URI="http://${PN}.sourceforge.net/${P/_/-}.tar.gz"
DESCRIPTION="A small 'net top' tool, grouping bandwidth by process"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="net-libs/libpcap"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -e "s:-O2:${CFLAGS}:g" -e "s:g++:$(tc-getCXX):g" \
		-e "s:gcc:$(tc-getCC):g" -i Makefile || die "sed failed."
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	dosbin ${PN} || die "dosbin failed."
	doman ${PN}.8
	dodoc Changelog DESIGN README
}
