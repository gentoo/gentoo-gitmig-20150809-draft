# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kadu/kadu-0.9.2.ebuild,v 1.4 2011/07/17 17:39:15 reavertm Exp $

EAPI="4"

inherit base cmake-utils flag-o-matic

MY_P="${P/_/-}"

DESCRIPTION="An open source Gadu-Gadu and Jabber/XMPP protocol Instant Messenger client."
HOMEPAGE="http://www.kadu.net"
SRC_URI="http://www.kadu.net/download/stable/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
SLOT="0"
#dbus tlen
IUSE="alsa ao +gadu kde phonon speech spell +ssl xmpp"
#tlen
REQUIRED_USE="
	|| (
		gadu
		xmpp
	)
"

#tlen tlen? ( net-dns/libidn )
COMMON_DEPEND="
	>=app-crypt/qca-2.0.0-r2
	>=media-libs/libsndfile-1.0
	>=net-libs/libgadu-1.9.0[threads]
	x11-libs/libXScrnSaver
	>=x11-libs/qt-dbus-4.4:4
	>=x11-libs/qt-gui-4.4:4[qt3support]
	>=x11-libs/qt-sql-4.4:4[sqlite]
	>=x11-libs/qt-svg-4.4:4
	>=x11-libs/qt-webkit-4.4:4
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	kde? ( >=kde-base/kdelibs-4.3.3 )
	phonon? (
		!kde? (
			|| (
				>=x11-libs/qt-phonon-4.4:4
				media-libs/phonon
			)
		)
		kde? ( media-libs/phonon )
	)
	spell? ( app-text/enchant )
	xmpp? ( net-dns/libidn )
"
DEPEND="${COMMON_DEPEND}
	xmpp? ( dev-util/automoc )
	x11-proto/scrnsaverproto
"
RDEPEND="${COMMON_DEPEND}
	speech? ( app-accessibility/powiedz )
	ssl? ( app-crypt/qca-ossl:2 )
"

# set given .config variable to =m or =y
# args: <variable> <m/y>
config_enable() {
	sed -i -e "s/^\(${1}=\)./\1${2}/" .config || die 'config_enable failed'
}

src_prepare() {
	# Autopatcher
	base_src_prepare

	# Create .config file with all variables defaulted to =n
	sed -i -n -e 's/=\(m\|y\)/=n/' -e '/^[a-z]/p' .config \
		|| die '.config creation failed'

	# Common modules
	# BLACKLISTED config_enable module_advanced_userlist m
	config_enable module_antistring m
	config_enable module_auto_hide m
	config_enable module_autoaway m
	config_enable module_autoresponder m
	config_enable module_autostatus m
	config_enable module_cenzor m
	config_enable module_config_wizard m
	config_enable module_desktop_docking m
	config_enable module_docking m
	# BLACKLISTED config_enable module_echo m
	config_enable module_exec_notify m
	config_enable module_ext_sound m
	config_enable module_filedesc m
	config_enable module_firewall m
	config_enable module_hints m
	config_enable module_history m
	config_enable module_idle m
	config_enable module_imagelink m
	config_enable module_last_seen m
	config_enable module_parser_extender m
	config_enable module_pcspeaker m
	config_enable module_qt4_docking m
	config_enable module_qt4_docking_notify m
	config_enable module_screenshot m
	config_enable module_simpleview m
	config_enable module_single_window m
	config_enable module_sms m
	config_enable module_sound m
	# BLACKLISTED config_enable module_split_messages m
	config_enable module_sql_history m
	config_enable module_tabs m
	# BLACKLISTED config_enable module_weather m
	config_enable module_word_fix m

	# Autodownloaded modules
	# config_enable module_anonymous_check m
	# config_enable module_globalhotkeys m
	# config_enable module_lednotify m
	# config_enable module_mime_tex m
	# config_enable module_nextinfo m
	# config_enable module_panelkadu m
	# config_enable module_senthistory m

	# Protocols
	if use gadu; then
		config_enable module_gadu_protocol m
		config_enable module_history_migration m
		config_enable module_profiles_import m
	fi
	use xmpp && config_enable module_jabber_protocol m
	# BLACKLISTED use tlen && config_enable module_tlen_protocol m

	# Audio outputs
	use alsa && config_enable module_alsa_sound m
	use ao && config_enable module_ao_sound m
	# BLACKLISTED use oss && config_enable module_dsp_sound m
	use phonon && config_enable module_phonon_sound m

	# Misc stuff
	# BLACKLISTED if use dbus; then
		# dbus interface for Kadu
		# BLACKLISTED config_enable module_dbus m
	# BLACKLISTED fi

	# Media players - no build time deps so build them all
	# bmpx_mediaplayer
	config_enable module_mediaplayer m
	# amarok1_mediaplayer m
	config_enable module_amarok2_mediaplayer m
	config_enable module_audacious_mediaplayer m
	config_enable module_dragon_mediaplayer m
	config_enable module_mpris_mediaplayer m
	# falf_mediaplayer
	# itunes_mediaplayer
	config_enable module_vlc_mediaplayer m
	# xmms2_mediaplayer
	# xmms_mediaplayer

	use kde && config_enable module_kde_notify m
	use speech && config_enable module_speech m
	use spell && config_enable module_spellchecker m
	if use ssl; then
		config_enable module_encryption_ng m
		config_enable module_encryption_ng_simlite m
	fi

	# Icons
	config_enable icons_default y
	config_enable icons_glass y
	config_enable icons_oxygen y
	# Uncomment when available
	# config_enable icons_tango y

	# Emoticons
	config_enable emoticons_penguins y
	config_enable emoticons_tango y
	# Uncomment when available
	# config_enable emoticons_gg6_compatible y

	# Sound themes
	config_enable sound_default y
	# Uncomment when available
	# config_enable sound_bns y
	# config_enable sound_drums y
	# config_enable sound_florkus y
	# config_enable sound_michalsrodek y
	# config_enable sound_percussion y
	# config_enable sound_ultr y
}

src_configure() {
	# Filter out dangerous flags
	filter-flags -fno-rtti
	strip-unsupported-flags

	# Ensure -DQT_NO_DEBUG is added
	append-cppflags -DQT_NO_DEBUG

	# Configure package
	local mycmakeargs=(
		-DBUILD_DESCRIPTION='Gentoo Linux'
		-DENABLE_AUTODOWNLOAD=OFF
		$(cmake-utils_use_with spell ENCHANT)
	)

	cmake-utils_src_configure
}
