# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qbittorrent/qbittorrent-0.9.1.ebuild,v 1.1 2007/04/04 09:32:58 armin76 Exp $

inherit eutils qt4

DESCRIPTION="BitTorrent client in C++ and Qt."
HOMEPAGE="http://www.qbittorrent.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-libs/rb_libtorrent-0.12_rc2
	$(qt4_min_version 4.2)
	>=dev-lang/python-2.3
	dev-libs/boost
	net-misc/curl"

pkg_setup() {
	if ! built_with_use "dev-libs/boost" threads && ! built_with_use "dev-libs/boost" threadsonly; then
		eerror "dev-libs/boost has to be built with threads or threadsonly USE-flag."
		die "Missing threads/threadsonly USE-flag for dev-libs/boost"
	fi
}

src_compile() {
	# econf fails, since this uses qconf
	./configure --prefix=/usr --qtdir=/usr \
		--with-libtorrent-inc=/usr/include \
		--with-libtorrent-lib=/usr/lib \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc AUTHORS Changelog NEWS README TODO
}
