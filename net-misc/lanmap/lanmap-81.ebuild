# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lanmap/lanmap-81.ebuild,v 1.1 2009/12/25 05:56:25 darkside Exp $

EAPI=2

inherit toolchain-funcs eutils

DESCRIPTION="lanmap sits quietly on a network and builds a picture of what it sees"
HOMEPAGE="http://www.parseerror.com/lanmap"
SRC_URI="http://www.parseerror.com/${PN}/rev/${PN}-2006-03-07-rev${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/libpcap
	 media-gfx/graphviz[png]"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch "${FILESDIR}"/makefile.patch
	chmod +x configure || die
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" || die
}

src_install() {
	emake prefix="${D}"/usr install || die
	dodoc {README,TODO}.txt || die
}
