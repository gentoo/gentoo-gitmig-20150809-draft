# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/btg/btg-0.9.6-r1.ebuild,v 1.1 2007/11/28 13:34:14 angelos Exp $

inherit eutils

DESCRIPTION="bittorrent client using rb_libtorrent"
HOMEPAGE="http://btg.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}-p1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc event-callback gtk minimal ncurses session test upnp webinterface"

RDEPEND="dev-libs/boost
	dev-libs/expat
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	dev-libs/libtasn1
	dev-util/dialog
	net-libs/gnutls
	net-libs/rb_libtorrent
	gtk? ( >=dev-cpp/gtkmm-2.4
		x11-libs/pango )
	webinterface? ( =dev-lang/php-5* )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.21
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${PN}-${PV/_rc*}"

pkg_setup() {
	if ! built_with_use --missing true "dev-libs/boost" threads && \
		! built_with_use --missing true "dev-libs/boost" threadsonly ; then
			echo
			elog "Compile dev-libs/boost with USE=threads or USE=threadsonly"
			elog "if you want threading support for btg"
			echo
	fi
}

src_compile() {
	local myconf=""

	if built_with_use --missing true "dev-libs/boost" threads || \
		built_with_use --missing true "dev-libs/boost" threadsonly ; then
			myconf="--with-boost-iostreams=boost_iostreams-mt \
				--with-boost-filesystem=boost_filesystem-mt \
				--with-boost-thread=boost_thread-mt \
				--with-boost-date-time=boost_date_time-mt \
				--with-boost-program_options=boost_program_options-mt"
	fi

	econf \
		$(use_enable debug) \
		$(use_enable gtk gui) \
		$(use_enable ncurses cli) \
		$(use_enable upnp) \
		$(use_enable event-callback) \
		$(use_enable session session-saving) \
		$(use_enable test unittest) \
		$(use_enable webinterface www) \
		$(use_enable !minimal command-list) \
		${myconf} \
		--disable-dependency-tracking \
		|| die

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README TODO

	newinitd "${FILESDIR}/btgd-init" ${PN}
	newconfd "${FILESDIR}/btgd-confd" ${PN}

	use gtk && make_desktop_entry btgui "BTG GUI Client" btg "Network;P2P"
}

pkg_postinst() {
	enewgroup p2p
	enewuser p2p -1 -1 /home/p2p p2p

	echo
	elog "BTG needs a daemon.ini and client.ini, to create them run btg-config"
	elog "and put them in the home of the user running btg (/home/p2p/.btg by default)"
	echo
}
