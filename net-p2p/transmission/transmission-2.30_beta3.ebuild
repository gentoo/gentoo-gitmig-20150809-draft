# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-2.30_beta3.ebuild,v 1.1 2011/04/29 06:30:12 pva Exp $

EAPI=4
inherit eutils fdo-mime gnome2-utils qt4-r2

MY_P="${P/_beta/b}"

DESCRIPTION="A Fast, Easy and Free BitTorrent client"
HOMEPAGE="http://www.transmissionbt.com/"
SRC_URI="http://download.transmissionbt.com/${PN}/files/${MY_P}.tar.xz"

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="gtk kde libnotify libcanberra qt4 utp"

# >=dev-libs/glib-2.28 is required for updated mime support. This makes gconf
# unnecessary for handling magnet links
RDEPEND="
	sys-libs/zlib
	>=dev-libs/libevent-2.0.10
	>=dev-libs/openssl-0.9.4
	|| ( >=net-misc/curl-7.16.3[ssl]
		>=net-misc/curl-7.16.3[gnutls] )
	gtk? ( >=dev-libs/glib-2.28:2
		>=x11-libs/gtk+-2.12:2
		>=dev-libs/dbus-glib-0.70
		libnotify? ( >=x11-libs/libnotify-0.4.3 )
		libcanberra? ( >=media-libs/libcanberra-0.10 ) )
	qt4? ( x11-libs/qt-gui:4[dbus] )"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-2.2.6b
	sys-devel/gettext
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	sys-apps/sed"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup transmission
	enewuser transmission -1 -1 -1 transmission
}

src_prepare() {
	sed -i -e 's:-ggdb3::g' configure || die
	# Magnet link support
	if use kde; then
		cat > qt/transmission-magnet.protocol <<-EOF
		[Protocol]
		exec=transmission-qt '%u'
		protocol=magnet
		Icon=transmission
		input=none
		output=none
		helper=true
		listing=
		reading=false
		writing=false
		makedir=false
		deleting=false
		EOF
	fi
}

src_configure() {
	# cli and daemon doesn't have external deps and are enabled by default
	econf \
		$(use_enable gtk) \
		$(use_enable utp) \
		$(use gtk && use_enable libnotify) \
		$(use gtk && use_enable libcanberra) \
		--disable-gconf2

	use qt4 && cd qt && eqmake4 qtr.pro
}

src_compile() {
	emake
	use qt4 && cd qt && emake
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc AUTHORS NEWS qt/README.txt
	rm -f "${ED}"/usr/share/${PN}/web/LICENSE

	newinitd "${FILESDIR}"/${PN}-daemon.initd.7 ${PN}-daemon
	newconfd "${FILESDIR}"/${PN}-daemon.confd.3 ${PN}-daemon

	keepdir /var/{transmission/{config,downloads},log/transmission}
	fowners -R transmission:transmission /var/{transmission/{,config,downloads},log/transmission}

	if use qt4; then
		cd qt
		emake INSTALL_ROOT="${D}/usr" install
		insinto /usr/share/applications/
		doins transmission-qt.desktop
		mv icons/transmission{,-qt}.png
		doicon icons/transmission-qt.png
		if use kde; then
			insinto /usr/share/kde4/services/
			doins transmission-magnet.protocol
		fi
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update

	# Keep default permissions on default dirs
	einfo "Seting owners of /var/{transmission/{,config,downloads},log/transmission}"
	chown -R transmission:transmission /var/{transmission/{,config,downloads},log/transmission}

	ewarn "If you use transmission-daemon, please, set 'rpc-username' and"
	ewarn "'rpc-password' (in plain text, transmission-daemon will hash it on"
	ewarn "start) in settings.json file located at /var/transmission/config or"
	ewarn "any other appropriate config directory."
	ewarn
	ewarn "You must change download location after you change a user daemon"
	ewarn "starts as, or it'll refuse to start, see bug #349867 for details."
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
