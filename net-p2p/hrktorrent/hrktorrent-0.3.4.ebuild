# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/hrktorrent/hrktorrent-0.3.4.ebuild,v 1.2 2009/05/08 18:07:48 armin76 Exp $

inherit toolchain-funcs

DESCRIPTION="A slim rb_libtorrent based console torrent application supporting DHT"
HOMEPAGE="http://50hz.ws/hrktorrent/"
SRC_URI="http://50hz.ws/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="~net-libs/rb_libtorrent-0.13"
DEPEND="${RDEPEND}
	dev-cpp/asio
	dev-util/pkgconfig"

src_compile() {
	tc-export CXX
	emake || die "emake failed."
}

src_install() {
	dobin ${PN} || die "dobin failed."
	doman ${PN}.1
	dodoc CHANGELOG README ${PN}.rc.example
}

pkg_postinst() {
	elog "Extract ${PN}.rc.example from /usr/share/doc/${PF} to"
	elog "home ~/.${PN}/${PN}.rc for example config."
}
