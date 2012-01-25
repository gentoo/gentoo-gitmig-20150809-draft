# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-2.42.ebuild,v 1.1 2012/01/25 14:33:01 scarabeus Exp $

EAPI=4
inherit eutils fdo-mime gnome2-utils qt4-r2 autotools

MY_P="${P/_beta/b}"

DESCRIPTION="A Fast, Easy and Free BitTorrent client"
HOMEPAGE="http://www.transmissionbt.com/"
SRC_URI="http://download.transmissionbt.com/${PN}/files/${MY_P}.tar.xz"

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk gtk3 kde nls qt4 utp"

RDEPEND="
	>=dev-libs/libevent-2.0.10
	>=dev-libs/openssl-0.9.4
	>=net-misc/curl-7.16.3[ssl]
	>=net-libs/miniupnpc-1.6
	net-libs/libnatpmp
	sys-libs/zlib
	gtk? (
		>=dev-libs/dbus-glib-0.70
		>=dev-libs/glib-2.28:2
		dev-libs/libappindicator:0
		>=x11-libs/gtk+-2.22:2
	)
	gtk3? (
		>=dev-libs/dbus-glib-0.70
		>=dev-libs/glib-2.28:2
		dev-libs/libappindicator:3
		>=x11-libs/gtk+-3.2:3
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
# Intltool/gettext are required as far as we eautoreconf for
# its autotools macros.
# If the source is not eautoreconfed we can keep it in nls.

S="${WORKDIR}/${MY_P}"

REQUIRED_USE="
	gtk? ( nls !gtk3 )
	gtk3? ( nls !gtk )
"

DOCS="AUTHORS NEWS qt/README.txt"

pkg_setup() {
	enewgroup transmission
	enewuser transmission -1 -1 -1 transmission
}

src_prepare() {
	# https://trac.transmissionbt.com/ticket/4323
	epatch "${FILESDIR}/${PN}-2.42-0001-configure.ac.patch"
	epatch "${FILESDIR}/${PN}-2.33-0002-config.in-4-qt.pro.patch"
	epatch "${FILESDIR}/${PN}-2.41-0003-system-miniupnpc.patch"
	epatch "${FILESDIR}/${PN}-2.42-0005-build-with-natpmp1.patch"

	# Fix build failure with USE=-utp, bug #290737
	epatch "${FILESDIR}/${PN}-2.41-noutp.patch"

	# Use system cflags
	epatch "${FILESDIR}/${PN}-2.42-respect-cflags.patch"

	# Use system natpmp
	epatch "${FILESDIR}/${PN}-2.42-natpmp-system.patch"

	# Upstream is not interested in this: https://trac.transmissionbt.com/ticket/4324
	sed -e 's|noinst\(_PROGRAMS = $(TESTS)\)|check\1|' -i libtransmission/Makefile.am || die

	eautoreconf

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
	local gtkver

	use gtk && gtkver="--with-gtk=2"
	use gtk3 && gtkver="--with-gtk=3"
	use gtk || use gtk3 || gtkver="--without-gtk"

	# cli and daemon doesn't have external deps and are enabled by default
	econf \
		${gtkver} \
		$(use_enable nls) \
		$(use_enable utp) \
		--enable-external-miniupnp \
		--enable-external-natpmp

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

	ewarn "If you use transmission-daemon, please, set 'rpc-username' and"
	ewarn "'rpc-password' (in plain text, transmission-daemon will hash it on"
	ewarn "start) in settings.json file located at /var/transmission/config or"
	ewarn "any other appropriate config directory."
	elog
	elog "To enable sound emerge media-libs/libcanberra and check that at least"
	elog "some sound them is selected. For this go:"
	elog "Gnome/system/preferences/sound themes tab and 'sound theme: default'"
	elog
	if use utp; then
		ewarn
		ewarn "Since uTP is enabled ${PN} needs large kernel buffers for the UDP socket."
		ewarn "Please, add into /etc/sysctl.conf following lines:"
		ewarn " net.core.rmem_max = 4194304"
		ewarn " net.core.wmem_max = 1048576"
		ewarn "and run sysctl -p"
	fi
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
