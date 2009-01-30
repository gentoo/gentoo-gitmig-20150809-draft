# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mumble/mumble-1.1.7.ebuild,v 1.1 2009/01/30 00:55:21 tgurr Exp $

EAPI="2"

inherit eutils multilib qt4

DESCRIPTION="Voice chat software for gaming written in Qt4."
HOMEPAGE="http://mumble.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa dbus debug g15 oss pch portaudio pulseaudio speech"

RDEPEND="dev-libs/boost
	>=media-libs/speex-1.2_beta3_p2
	x11-libs/qt-core:4[ssl]
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-sql:4[sqlite]
	alsa? ( media-libs/alsa-lib )
	dbus? ( x11-libs/qt-dbus:4 )
	g15? ( app-misc/g15daemon )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	speech? ( app-accessibility/speech-dispatcher )"

DEPEND="${RDEPEND}"

src_configure() {
	local conf_add

	if has_version '<=sys-devel/gcc-4.2'; then
		conf_add="${conf_add} no-pch"
	else
		use pch || conf_add="${conf_add} no-pch"
	fi

	use alsa || conf_add="${conf_add} no-alsa"
	use dbus || conf_add="${conf_add} no-dbus"
	use debug && conf_add="${conf_add} symbols debug" || conf_add="${conf_add} release"
	use g15 || conf_add="${conf_add} no-g15"
	use oss || conf_add="${conf_add} no-oss"
	use portaudio || conf_add="${conf_add} no-portaudio"
	use pulseaudio || conf_add="${conf_add} no-pulseaudio"
	use speech || conf_add="${conf_add} no-speechd"

	eqmake4 "${S}/main.pro" -recursive \
		CONFIG+="${conf_add} no-bundled-speex no-embed-qt-translations no-server no-xevie" \
		DEFINES+="PLUGIN_PATH=/usr/$(get_libdir)/mumble" \
		|| die "eqmake4 failed."
}

src_install() {
	newdoc README.Linux README || die "Installing docs failed."
	dodoc CHANGES || die "Installing docs failed."

	local dir
	if use debug; then
		dir=debug
	else
		dir=release
	fi

	dobin "${dir}"/mumble || die "Installing mumble binary failed."

	CONF_LIBDIR="$(get_libdir)/mumble" dolib.so "${dir}"/lib*.so* || die "Installing libraries failed."
	CONF_LIBDIR="$(get_libdir)/mumble" dolib.so "${dir}"/plugins/lib*.so* || die "Installing libraries failed."

	insinto /usr/share/services
	doins scripts/mumble.protocol || die "Installing mumble.protocol file failed."

	dobin scripts/mumble-overlay || die "Installing overlay script failed."

	newicon icons/mumble.64x64.png mumble.png || die "Installing icon failed."

	make_desktop_entry ${PN} "Mumble" mumble "Qt;KDE;Network;Telephony;" \
		|| die "Installing menu entry failed."

	doman man/mumble-overlay.1 || die "Installing mumble-overlay manpage failed."
	doman man/mumble.1 || die "Installing mumble manpage failed."
}

pkg_postinst() {
	echo
	elog "Visit http://mumble.sourceforge.net/Audio_Tuning for futher configuration."
	elog "Run mumble-overlay to start the OpenGL overlay (after starting mumble)."
	echo
}
