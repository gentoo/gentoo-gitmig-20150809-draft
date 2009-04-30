# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kadu/kadu-0.6.5.2.ebuild,v 1.1 2009/04/30 12:17:03 cla Exp $

inherit base cmake-utils flag-o-matic

EAPI="2"

DESCRIPTION="QT client for popular in Poland Gadu-Gadu instant messaging network"
HOMEPAGE="http://www.kadu.net"
SRC_URI="http://www.kadu.net/download/stable/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="alsa amarok amarok2 ao audacious +avatar bmpx config_wizard dragonplayer
oss phonon sms spell +ssl vlc voice"

COMMON_DEPEND="
	>=media-libs/libsndfile-1.0
	>=net-libs/libgadu-1.8[threads]
	>=x11-libs/qt-dbus-4.4:4
	>=x11-libs/qt-gui-4.4:4
	>=x11-libs/qt-webkit-4.4:4
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	spell? ( app-text/aspell )
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/cmake-2.6
"
RDEPEND="${COMMON_DEPEND}
	amarok? ( media-sound/amarok:0 )
	amarok2? ( media-sound/amarok:2 )
	audacious? ( media-sound/audacious )
	bmpx? ( media-sound/bmpx )
	dragonplayer? ( kde-base/dragonplayer )
	vlc? ( media-video/vlc )
"

S="${WORKDIR}/${PN}"

PATCHES=(
	"${FILESDIR}/libgsm-ugly-code.patch"
)

# set given .config variable to =m or =y
# args: <variable> <m/y>
config_enable() {
	sed -i -e "s/^\(${1}=\)./\1${2}/" .config || die "config_enable failed"
}

src_prepare() {
	# Autopatcher
	base_src_prepare

	# Multilib
	sed -i -e 's|${CMAKE_INSTALL_PREFIX}/lib|${CMAKE_INSTALL_PREFIX}/lib${LIB_SUFFIX}|' \
		CMakeLists.txt || die "failed to apply multilib installation patch"
	find modules -name CMakeLists.txt \
		-exec sed -i -e 's|lib/kadu/modules|lib${LIB_SUFFIX}/kadu/modules|' {} + \
		|| die "failed to fix multilib paths for modules"

	# Create .config file with all variables defaulted to =n
	sed -i -n -e "s/=\(m\|y\)/=n/" -e "/^[a-z]/p" .config \
		|| die ".config creation failed"

	# Common modules
	config_enable module_gadu_protocol y
	config_enable module_account_management m
	config_enable module_advanced_userlist m
	config_enable module_antistring m
	config_enable module_auto_hide m
	config_enable module_autoaway m
	config_enable module_autoresponder m
	config_enable module_autostatus m
	config_enable module_cenzor m
	config_enable module_dcc m
	config_enable module_desktop_docking m
	config_enable module_docking m
	config_enable module_echo m
	config_enable module_exec_notify m
	config_enable module_ext_sound m
	config_enable module_filedesc m
	config_enable module_filtering m
	config_enable module_firewall m
	config_enable module_hints m
	config_enable module_history m
	config_enable module_last_seen m
	config_enable module_notify m
	config_enable module_parser_extender m
	config_enable module_pcspeaker m
	config_enable module_qt4_docking m
	config_enable module_qt4_sound m
	config_enable module_screenshot m
	config_enable module_sound m
	config_enable module_window_notify m
	config_enable module_word_fix m
	config_enable module_nextinf m

	# Media players
	if use amarok || use amarok2 || use audacious || use bmpx || use dragonplayer || use vlc; then
		config_enable module_mediaplayer m
		use amarok && config_enable amarok1_mediaplayer m
		use amarok2 && config_enable amarok2_mediaplayer m
		use audacious && config_enable audacious_mediaplayer m
		use bmpx && config_enable bmpx_mediaplayer m
		use dragonplayer && config_enable dragon_mediaplayer m
		# falf_mediaplayer
		# itunes_mediaplayer
		use vlc && config_enable vlc_mediaplayer m
		# xmms2_mediaplayer
		# xmms_mediaplayer
	fi

	# Audio outputs
	use alsa && config_enable module_alsa_sound m
	use ao && config_enable module_ao_sound m
	use oss && config_enable modules_dsp_sound m

	# Misc stuff
	use config_wizard && config_enable module_config_wizard m
	use spell && config_enable module_spellchecker m
	use ssl && config_enable module_encryption m
	use voice && config_enable module_voice m
	use avatar && config_enable module_gg_avatars m

	# SMS related modules
	if use sms; then
		config_enable module_default_sms m
		config_enable module_sms m
	fi

	# Icons
	config_enable icons_default y
	# Uncomment when available
	# config_enable icons_glass16 y
	# config_enable icons_glass22 y
	# config_enable icons_kadu05 y
	# config_enable icons_oxygen16 y
	# config_enable icons_tango16 y

	# Emoticons
	config_enable emoticons_penguins y
	# Uncomment when available
	# config_enable emoticons_gg6_compatible y
	# config_enable emoticons_tango y

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
	mycmakeargs="${mycmakeargs}
		-D BUILD_DESCRIPTION:STRING=Gentoo Linux
		-D ENABLE_AUTDOWNLOAD:BOOL=NO"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# delete unneeded .a files from modules directory
	rm -f "${D}"/usr/lib/kadu/modules/*.a
}
