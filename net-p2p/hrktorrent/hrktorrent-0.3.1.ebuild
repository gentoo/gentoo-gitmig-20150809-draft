# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/hrktorrent/hrktorrent-0.3.1.ebuild,v 1.2 2008/04/10 14:45:52 drac Exp $

inherit toolchain-funcs

DESCRIPTION="A slim rb_libtorrent based console torrent application supporting DHT"
HOMEPAGE="http://henrik.unit5.ca/hrktorrent"
SRC_URI="http://henrik.unit5.ca/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">=net-libs/rb_libtorrent-0.12"
DEPEND="${RDEPEND}
	dev-cpp/asio
	dev-util/pkgconfig"

src_compile() {
	emake CXX="$(tc-getCXX)" || die "emake failed."
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc CHANGELOG README ${PN}.rc.example
}

pkg_postinst() {
	elog "Extract ${PN}.rc.example from /usr/share/doc/${PF} to"
	elog "home ~/.${PN}/${PN}.rc for example config."
}
