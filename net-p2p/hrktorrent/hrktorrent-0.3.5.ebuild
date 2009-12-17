# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/hrktorrent/hrktorrent-0.3.5.ebuild,v 1.3 2009/12/17 20:11:36 maekke Exp $

inherit toolchain-funcs

DESCRIPTION="a light console torrent client written in C++, using rasterbar's libtorrent"
HOMEPAGE="http://50hz.ws/hrktorrent/"
SRC_URI="http://50hz.ws/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="=net-libs/rb_libtorrent-0.14*"
DEPEND="${RDEPEND}
	dev-cpp/asio
	dev-util/pkgconfig"

src_compile() {
	tc-export CXX
	emake || die
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1
	dodoc CHANGELOG CONTRIBUTORS README ${PN}.rc.example
}
