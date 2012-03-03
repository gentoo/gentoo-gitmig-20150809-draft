# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-2.42-r1.ebuild,v 1.4 2012/03/03 15:47:22 maekke Exp $

EAPI=4
inherit autotools eutils fdo-mime gnome2-utils qt4-r2

DESCRIPTION="A Fast, Easy and Free BitTorrent client"
HOMEPAGE="http://www.transmissionbt.com/"
SRC_URI="http://download.transmissionbt.com/${PN}/files/${P}.tar.xz
	http://dev.gentoo.org/~ssuominen/${P}-patchset-1.tar.xz"

LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="ayatana gtk kde nls qt4"

RDEPEND="
	>=dev-libs/libevent-2.0.10
	dev-libs/openssl:0
	>=net-misc/curl-7.16.3[ssl]
	>=net-libs/miniupnpc-1.6
	net-libs/libnatpmp
	sys-libs/zlib
	gtk? (
		>=dev-libs/dbus-glib-0.98
		>=dev-libs/glib-2.28
		>=x11-libs/gtk+-3.2:3
		ayatana? ( dev-libs/libappindicator:3 )
		)
	qt4? ( x11-libs/qt-gui:4[dbus] )"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-apps/sed
	sys-devel/gettext
	>=sys-devel/libtool-2.2.6b
	nls? (
		>=dev-util/intltool-0.40
		sys-devel/gettext
		)"
# note: gettext is always a depend with eautoreconf

REQUIRED_USE="
	ayatana? ( gtk )
	gtk? ( nls )"

DOCS="AUTHORS NEWS qt/README.txt"

pkg_setup() {
	enewgroup transmission
	enewuser transmission -1 -1 -1 transmission
}

src_prepare() {
	# note: this patchset has useless bits for optionalizing UTP which can be
	# dropped from next one
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patches

	# note: http://trac.transmissionbt.com/ticket/4324
	sed -i -e 's|noinst\(_PROGRAMS = $(TESTS)\)|check\1|' libtransmission/Makefile.am || die

	if ! use ayatana; then
		sed -i -e '/^LIBAPPINDICATOR_MINIMUM/s:=.*:=9999:' configure.ac || die
	fi

	sed -i -e '/CFLAGS/s:-ggdb3::' configure.ac || die

	eautoreconf

	# note: magnet link support
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
	# note: cli and daemon doesn't have external deps and are enabled by default
	econf \
		$(use_enable nls) \
		--enable-utp \
		--enable-external-miniupnp \
		--enable-external-natpmp \
		$(use_with gtk)

	use qt4 && cd qt && eqmake4 qtr.pro
}

src_compile() {
	emake
	use qt4 && cd qt && emake
}

src_install() {
	default

	rm -f "${ED}"/usr/share/${PN}/web/LICENSE

	newinitd "${FILESDIR}"/${PN}-daemon.initd.8 ${PN}-daemon
	newconfd "${FILESDIR}"/${PN}-daemon.confd.3 ${PN}-daemon

	keepdir /var/{transmission/{config,downloads},log/transmission}
	fowners -R transmission:transmission /var/{transmission/{,config,downloads},log/transmission}

	if use qt4; then
		cd qt
		emake INSTALL_ROOT="${D}"/usr install
		insinto /usr/share/applications
		doins transmission-qt.desktop
		mv -vf icons/transmission{,-qt}.png
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

	ewarn "If you use transmission-daemon, please, set 'rpc-username' and"
	ewarn "'rpc-password' (in plain text, transmission-daemon will hash it on"
	ewarn "start) in settings.json file located at /var/transmission/config or"
	ewarn "any other appropriate config directory."
	elog
	elog "To enable sound emerge media-libs/libcanberra and check that at least"
	elog "some sound them is selected. For this go:"
	elog "Gnome/system/preferences/sound themes tab and 'sound theme: default'"
	elog
	ewarn "Since uTP is enabled ${PN} needs large kernel buffers for the UDP socket."
	ewarn "Please, add into /etc/sysctl.conf following lines:"
	ewarn " net.core.rmem_max = 4194304"
	ewarn " net.core.wmem_max = 1048576"
	ewarn "and run sysctl -p"
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
