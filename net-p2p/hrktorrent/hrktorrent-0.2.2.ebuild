# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/hrktorrent/hrktorrent-0.2.2.ebuild,v 1.2 2007/11/26 19:32:46 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A slim rb_libtorrent based console torrent application supporting DHT"
HOMEPAGE="http://henrik.unit5.ca/hrktorrent"
SRC_URI="http://henrik.unit5.ca/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=net-libs/rb_libtorrent-0.12*"
DEPEND="${RDEPEND}
	dev-cpp/asio
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Makefile is confusing LIBS with LDFLAGS and CFLAGS with CXXFLAGS.
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	emake CXX="$(tc-getCXX)" || die "emake failed."
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc CHANGELOG README ${PN}.rc.example
}

pkg_postinst() {
	local docsuffix=$(ecompress --suffix)

	elog "A sample configuration file for ${PN} can be found in"
	elog "/usr/share/doc/${PF}/hrktorrent.rc.example${docsuffix}"
	elog "To use a config file, extract it, put it in your home directory"
	elog "and name it \".hrktorrent.rc\""
}
