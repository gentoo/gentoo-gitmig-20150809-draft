# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nethogs/nethogs-0.6.1_pre2.ebuild,v 1.4 2009/04/29 06:52:33 ssuominen Exp $

inherit eutils toolchain-funcs

HOMEPAGE="http://nethogs.sf.net/"
SRC_URI="http://${PN}.sourceforge.net/${P/_/-}.tar.gz"
DESCRIPTION="A small 'net top' tool, grouping bandwidth by process"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="net-libs/libpcap
	sys-libs/ncurses"
DEPEND="${RDEPEND}"

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
