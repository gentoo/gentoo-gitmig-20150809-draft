# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-mobility/qt-mobility-1.2.0.ebuild,v 1.3 2012/04/04 15:43:36 pesa Exp $

EAPI=4

inherit multilib qt4-r2

MY_P="${PN}-opensource-src-${PV}"

DESCRIPTION="Additional Qt APIs for mobile devices and desktop platforms"
HOMEPAGE="http://qt.nokia.com/products/qt-addons/mobility"
SRC_URI="http://get.qt.nokia.com/qt/add-ons/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

QT_MOBILITY_MODULES="bearer connectivity contacts feedback gallery
		location messaging multimedia organizer publishsubscribe
		sensors serviceframework systeminfo versit"
IUSE="bluetooth debug doc networkmanager opengl pulseaudio qml +tools
	${QT_MOBILITY_MODULES}"

REQUIRED_USE="
	versit? ( contacts )
"

RDEPEND="
	=x11-libs/qt-core-4.7*
	bearer? (
		networkmanager? (
			net-misc/networkmanager
			=x11-libs/qt-dbus-4.7*
		)
	)
	connectivity? (
		=x11-libs/qt-dbus-4.7*
		bluetooth? ( net-wireless/bluez )
	)
	gallery? ( =x11-libs/qt-dbus-4.7* )
	location? (
		=x11-libs/qt-gui-4.7*
		=x11-libs/qt-sql-4.7*[sqlite]
	)
	messaging? ( ~net-libs/qmf-2.0_p201143 )
	multimedia? (
		media-libs/alsa-lib
		>=media-libs/gstreamer-0.10.19:0.10
		>=media-libs/gst-plugins-base-0.10.19:0.10
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXv
		=x11-libs/qt-gui-4.7*
		opengl? ( =x11-libs/qt-opengl-4.7* )
		pulseaudio? ( media-sound/pulseaudio[alsa] )
	)
	publishsubscribe? (
		tools? ( =x11-libs/qt-gui-4.7* )
	)
	qml? ( =x11-libs/qt-declarative-4.7* )
	serviceframework? (
		=x11-libs/qt-dbus-4.7*
		=x11-libs/qt-sql-4.7*[sqlite]
		tools? ( =x11-libs/qt-gui-4.7* )
	)
	systeminfo? (
		sys-apps/util-linux
		sys-fs/udev
		x11-libs/libX11
		x11-libs/libXrandr
		=x11-libs/qt-dbus-4.7*
		=x11-libs/qt-gui-4.7*
		bluetooth? ( net-wireless/bluez )
		networkmanager? ( net-misc/networkmanager )
	)
	versit? ( =x11-libs/qt-gui-4.7* )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	multimedia? (
		sys-kernel/linux-headers
		x11-proto/videoproto
	)
	systeminfo? ( sys-kernel/linux-headers )
"
PDEPEND="
	connectivity? (
		bluetooth? ( app-mobilephone/obexd )
	)
"

S=${WORKDIR}/${MY_P}

DOCS="changes-${PV}"

pkg_setup() {
	# figure out which modules to build
	modules=
	local m=( ${QT_MOBILITY_MODULES} )
	for mod in ${m[@]#[+-]}; do
		use ${mod} && modules+="${mod} "
	done

	if [[ -z ${modules} ]]; then
		ewarn "At least one module must be selected for building, but you have selected none."
		ewarn "The QtContacts module will be automatically enabled."
		modules="contacts"
	fi
}

src_prepare() {
	qt4-r2_src_prepare

	# translations aren't really translated: disable them
	sed -i -e '/SUBDIRS +=/s:translations::' qtmobility.pro || die

	# fix automagic dependency on qt-opengl
	if ! use opengl; then
		sed -i -e '/QT +=/s:opengl::' src/multimedia/multimedia.pro || die
	fi
	# fix automagic dependency on qt-declarative
	if ! use qml; then
		sed -i -e '/SUBDIRS += declarative/d' plugins/plugins.pro || die
	fi
}

src_configure() {
	if use messaging; then
		# tell configure/qmake where QMF is installed
		export QMF_INCLUDEDIR="${EPREFIX}"/usr/include/qt4/qmfclient
		export QMF_LIBDIR="${EPREFIX}"/usr/$(get_libdir)/qt4
	fi

	# custom configure script
	set -- ./configure -no-docs \
		-prefix "${EPREFIX}/usr" \
		-headerdir "${EPREFIX}/usr/include/qt4" \
		-libdir "${EPREFIX}/usr/$(get_libdir)/qt4" \
		-plugindir "${EPREFIX}/usr/$(get_libdir)/qt4/plugins" \
		$(use debug && echo -debug || echo -release) \
		$(use tools || echo -no-tools) \
		-modules "${modules}"
	echo "$@"
	"$@" || die "configure failed"

	# fix automagic dependency on bluez
	if ! use bluetooth; then
		sed -i -e '/^bluez_enabled =/s:yes:no:' config.pri || die
	fi
	# fix automagic dependency on networkmanager
	if ! use networkmanager; then
		sed -i -e '/^networkmanager_enabled =/s:yes:no:' config.pri || die
	fi
	# fix automagic dependency on pulseaudio
	if ! use pulseaudio; then
		sed -i -e '/^pulseaudio_enabled =/s:yes:no:' config.pri || die
	fi

	eqmake4 -recursive
}

src_install() {
	qt4-r2_src_install

	if use doc; then
		dohtml -r doc/html/*
		dodoc doc/qch/qtmobility.qch
		docompress -x /usr/share/doc/${PF}/qtmobility.qch
	fi
}
