# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-2.50-r1.ebuild,v 1.1 2012/03/02 03:10:04 ssuominen Exp $

EAPI=4
LANGS="en es kk lt pt_BR ru"
inherit autotools eutils fdo-mime gnome2-utils qt4-r2

DESCRIPTION="A Fast, Easy and Free BitTorrent client"
HOMEPAGE="http://www.transmissionbt.com/"
SRC_URI="http://download.transmissionbt.com/${PN}/files/${P}.tar.xz"

LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="ayatana gtk kde nls qt4 xfs"

RDEPEND="
	>=dev-libs/libevent-2.0.10
	dev-libs/openssl:0
	net-libs/libnatpmp
	>=net-libs/miniupnpc-1.6
	>=net-misc/curl-7.16.3[ssl]
	sys-libs/zlib
	gtk? (
		>=dev-libs/dbus-glib-0.98
		>=dev-libs/glib-2.28
		>=x11-libs/gtk+-3.2:3
		ayatana? ( dev-libs/libappindicator:3 )
		)
	qt4? (
		x11-libs/qt-core:4
		x11-libs/qt-gui:4[dbus]
		)"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	virtual/os-headers
	nls? (
		>=dev-util/intltool-0.40
		sys-devel/gettext
		)
	xfs? ( sys-fs/xfsprogs )"
# note: gettext is always a depend with eautoreconf

REQUIRED_USE="
	ayatana? ( gtk )
	kde? ( qt4 )"

DOCS="AUTHORS NEWS qt/README.txt"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 -1 ${PN}
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-build-with-natpmp1.patch

	sed -i -e '/CFLAGS/s:-ggdb3::' configure.ac
	use ayatana || sed -i -e '/^LIBAPPINDICATOR_MINIMUM/s:=.*:=9999:' configure.ac

	# http://trac.transmissionbt.com/ticket/4324
	sed -i -e 's|noinst\(_PROGRAMS = $(TESTS)\)|check\1|' lib${PN}/Makefile.am || die

	eautoreconf

	if use kde; then
		cat <<-EOF > "${T}"/${PN}-magnet.protocol
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
	export ac_cv_header_xfs_xfs_h=$(usex xfs)

	econf \
		--enable-external-natpmp \
		$(use_enable nls) \
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
		pushd qt >/dev/null
		emake INSTALL_ROOT="${D}"/usr install

		domenu ${PN}-qt.desktop
		doicon icons/${PN}-qt.png

		if use nls; then
			insinto /usr/share/qt4/translations
			local lang
			for lang in ${LANGS}; do
				if use linguas_${lang}; then
					lrelease translations/${PN}_${lang}.ts || die
					doins translations/${PN}_${lang}.qm
				fi
			done
		fi

		if use kde; then
			insinto /usr/share/kde4/services
			doins "${T}"/${PN}-magnet.protocol
		fi
		popd >/dev/null
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
