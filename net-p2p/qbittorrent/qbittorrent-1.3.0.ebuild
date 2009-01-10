# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qbittorrent/qbittorrent-1.3.0.ebuild,v 1.1 2009/01/10 18:00:49 armin76 Exp $

EAPI="1"

inherit eutils qt4 multilib

MY_P="${P/_/}"

DESCRIPTION="BitTorrent client in C++ and Qt."
HOMEPAGE="http://www.qbittorrent.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( x11-libs/qt-gui:4 =x11-libs/qt-4.3* )
	>=net-libs/rb_libtorrent-0.14.1
	dev-libs/boost
	net-misc/curl
	dev-cpp/commoncpp2"
RDEPEND="${DEPEND}
	>=dev-lang/python-2.3"

pkg_setup() {
	# We need boost built with threads
	if ! built_with_use --missing true "dev-libs/boost" threads; then
		eerror "${PN} needs dev-libs/boost built with threads USE flag"
		die "dev-libs/boost is built without threads USE flag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Respect LDFLAGS
	sed -i -e 's/-Wl,--as-needed/$(LDFLAGS)/g' src/src.pro
}

src_compile() {
	# econf fails, since this uses qconf
	./configure --prefix=/usr --qtdir=/usr \
		--with-libtorrent-inc=/usr/include \
		--with-libtorrent-lib=/usr/$(get_libdir) \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc AUTHORS Changelog NEWS README TODO
}
