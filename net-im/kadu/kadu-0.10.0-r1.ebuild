# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kadu/kadu-0.10.0-r1.ebuild,v 1.3 2011/10/18 20:42:39 reavertm Exp $

EAPI="4"

inherit base cmake-utils flag-o-matic

MY_P="${P/_/-}"

DESCRIPTION="An open source Gadu-Gadu and Jabber/XMPP protocol Instant Messenger client."
HOMEPAGE="http://www.kadu.net"
SRC_URI="http://download.kadu.im/stable/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="+gadu phonon sdk speech spell xmpp"
REQUIRED_USE="
	|| (
		gadu
		xmpp
	)
"
COMMON_DEPEND="
	>=app-crypt/qca-2.0.0-r2
	>=media-libs/libsndfile-1.0
	>=net-libs/libgadu-1.11.0[threads]
	x11-libs/libXfixes
	x11-libs/libXScrnSaver
	>=x11-libs/qt-dbus-4.7.0:4
	>=x11-libs/qt-gui-4.7.0:4
	>=x11-libs/qt-script-4.7.0:4
	>=x11-libs/qt-sql-4.7.0:4[sqlite]
	>=x11-libs/qt-svg-4.7.0:4
	>=x11-libs/qt-webkit-4.7.0:4
	gadu? ( >=x11-libs/qt-xmlpatterns-4.7.0:4 )
	phonon? (
		|| (
			media-libs/phonon
			>=x11-libs/qt-phonon-4.7.0:4
		)
	)
	spell? ( app-text/enchant )
	xmpp? (
		net-dns/libidn
		sys-libs/zlib
	)
"
DEPEND="${COMMON_DEPEND}
	x11-proto/fixesproto
	x11-proto/scrnsaverproto
"
RDEPEND="${COMMON_DEPEND}
	app-crypt/qca-ossl:2
	speech? ( app-accessibility/powiedz )
"

PATCHES=(
	"${FILESDIR}/${P}-cmake.patch"
	"${FILESDIR}/${P}-sdk-cmake.patch"
)

PLUGINS='amarok1_mediaplayer antistring auto_hide autoaway autoresponder
autostatus cenzor chat_notify config_wizard desktop_docking docking
encryption_ng encryption_ng_simlite exec_notify ext_sound falf_mediaplayer
filedesc firewall freedesktop_notify hints history idle imagelink last_seen
mediaplayer mprisplayer_mediaplayer pcspeaker qt4_docking qt4_docking_notify
screenshot simpleview single_window sms sound sql_history tabs word_fix'

src_configure() {
	# Filter out dangerous flags
	filter-flags -fno-rtti
	strip-unsupported-flags

	# Ensure -DQT_NO_DEBUG is added
	append-cppflags -DQT_NO_DEBUG

	# Plugin selection
	if use gadu; then
		PLUGINS+=' gadu_protocol history_migration profiles_import'
	fi

	use xmpp && PLUGINS+=' jabber_protocol'
	use phonon && PLUGINS+=' phonon_sound'
	use speech && PLUGINS+=' speech'
	use spell && PLUGINS+=' spellchecker'

	# COMPILE_PLUGINS isn't the most flexible..
	local compile_plugins=
	for plugin in ${PLUGINS}; do
		[[ -n ${compile_plugins} ]] && compile_plugins+=','
		compile_plugins+="${plugin}"
	done
	unset PLUGINS

	# Configure package
	local mycmakeargs=(
		-DBUILD_DESCRIPTION='Gentoo Linux'
		-DCOMPILE_PLUGINS="${compile_plugins}"
		$(cmake-utils_use sdk INSTALL_SDK)
		$(cmake-utils_use_with spell ENCHANT)
	)
	unset compile_plugins

	cmake-utils_src_configure
}
