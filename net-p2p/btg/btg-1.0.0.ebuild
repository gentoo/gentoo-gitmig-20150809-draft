# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/btg/btg-1.0.0.ebuild,v 1.1 2009/07/02 22:55:49 yngwin Exp $

EAPI="2"
inherit eutils autotools

MY_P="${P/_/-}"

DESCRIPTION="A bittorrent client using rb_libtorrent with a daemon/client model"
HOMEPAGE="http://btg.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="curl debug doc event-callback gtk minimal ncurses session test upnp webinterface"

RDEPEND=">=dev-libs/boost-1.35
	dev-libs/expat
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	dev-libs/libtasn1
	net-libs/gnutls
	net-libs/rb_libtorrent
	curl? ( net-misc/curl )
	gtk? ( dev-cpp/gtkmm:2.4
		dev-libs/libsigc++:2
		sci-libs/plotmm
		x11-libs/pango )
	!minimal? ( dev-util/dialog )
	ncurses? ( sys-libs/ncurses )
	test? ( dev-util/cppunit )
	upnp? ( >=net-libs/rb_libtorrent-0.14 )
	webinterface? ( dev-lang/php:5[xml,zlib] virtual/httpd-cgi )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${P%_*}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gnutls-pc.patch  # bug 275850
	epatch "${FILESDIR}"/${P}-gcc44.patch
	eautoreconf
}

src_configure() {
	econf LIBS="-lboost_thread -lboost_date_time" \
		$(use_enable curl url) \
		$(use_enable debug) \
		$(use_enable gtk gui) \
		$(use_enable ncurses cli) \
		$(use_enable event-callback) \
		$(use_enable session session-saving) \
		$(use_enable test unittest) \
		$(use_enable upnp) \
		$(use_enable webinterface www) \
		$(use_enable !minimal command-list) \
		$(use_enable !minimal btg-config) \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'

	dodoc AUTHORS ChangeLog README TODO

	newinitd "${FILESDIR}/btgd-init" ${PN}
	newconfd "${FILESDIR}/btgd-confd" ${PN}

	use gtk && make_desktop_entry btgui "BTG GUI Client" btg "Network;P2P"
}

pkg_postinst() {
	enewgroup p2p
	enewuser p2p -1 -1 /home/p2p p2p

	echo
	elog "BTG needs a daemon.ini and client.ini. To create them run btg-config and"
	elog "put them in the home of the user running btg (/home/p2p/.btg by default)"
	echo
}
