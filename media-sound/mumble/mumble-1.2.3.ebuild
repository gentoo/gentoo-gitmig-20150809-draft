# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mumble/mumble-1.2.3.ebuild,v 1.1 2011/02/20 22:11:52 tgurr Exp $

EAPI="2"

inherit eutils multilib qt4-r2

DESCRIPTION="Mumble is an open source, low-latency, high quality voice chat software"
HOMEPAGE="http://mumble.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa +dbus debug g15 oss pch portaudio pulseaudio speech zeroconf"

RDEPEND=">=dev-libs/boost-1.41.0
	>=dev-libs/openssl-1.0.0b
	>=dev-libs/protobuf-2.2.0
	>=media-libs/libsndfile-1.0.20[-minimal]
	>=media-libs/speex-1.2_rc1
	sys-apps/lsb-release
	x11-libs/qt-core:4[ssl]
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-sql:4[sqlite]
	x11-libs/qt-svg:4
	x11-libs/qt-xmlpatterns:4
	x11-proto/inputproto
	alsa? ( media-libs/alsa-lib )
	dbus? ( x11-libs/qt-dbus:4 )
	g15? ( app-misc/g15daemon )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	speech? ( app-accessibility/speech-dispatcher )
	zeroconf? ( || ( net-dns/avahi[mdnsresponder-compat] net-misc/mDNSResponder ) )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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
	use zeroconf || conf_add="${conf_add} no-bonjour"

	eqmake4 "${S}/main.pro" -recursive \
		CONFIG+="${conf_add} \
			no-11x \
			no-bundled-speex \
			no-embed-qt-translations \
			no-server \
			no-update" \
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
	dobin scripts/mumble-overlay || die "Installing overlay script failed."

	insinto /usr/share/services
	doins scripts/mumble.protocol || die "Installing mumble.protocol file failed."

	domenu scripts/mumble.desktop || die "Installing menu entry failed."

	insinto /usr/share/icons/hicolor/scalable/apps
	doins icons/mumble.svg || die "Installing icon failed."

	doman man/mumble-overlay.1 || die "Installing mumble-overlay manpage failed."
	doman man/mumble.1 || die "Installing mumble manpage failed."

	insopts -o root -g root -m 0755
	insinto "/usr/$(get_libdir)/mumble"
	doins "${dir}"/libmumble.so.${PV} || die "Installing mumble lib failed."
	doins "${dir}"/libcelt0.so.0.{7,11}.0 || die "Installing celt libs failed."
	doins "${dir}"/plugins/lib*.so* || die "Installing plugins failed."
}

pkg_postinst() {
	echo
	elog "Visit http://mumble.sourceforge.net/ for futher configuration instructions."
	elog "Run mumble-overlay to start the OpenGL overlay (after starting mumble)."
	echo
}
