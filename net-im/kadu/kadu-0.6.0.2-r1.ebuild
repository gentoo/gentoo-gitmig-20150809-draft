# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kadu/kadu-0.6.0.2-r1.ebuild,v 1.2 2009/02/08 14:07:02 maekke Exp $

inherit flag-o-matic eutils autotools

AGENT="0.4.4"			#http://www.kadu.net/w/Agent
TABS="1.1.6"			#http://www.kadu.net/w/Tabs
LED_NOTIFY="0.18"		#http://www.kadu.net/~blysk/
FILTERING="20080224"	#http://www.kadu.net/~pinkworm/filtering/
SCREENSHOT="20080104"
OSD_NOTIFY="0.4.2"		#http://www.kadu.net/forum/viewtopic.php?t=8879
PROFILES="0.3.1"		#http://www.kadu.net/forum/viewtopic.php?t=6282
FIREWALL="0.7.5.1"

SPELLCHECKER="20071230"
MAIL="0.3.3"

POWERKADU="2.0.4"
ANONYM_CHECK="0.2"
ANTYSTRING="0.2"
AUTOHIDE="0.2.1"
AUTOSTATUS="0.1"
CENZOR="0.2"
SPLITMESG="0.2"
WORDFIX="0.3"
PARSEREXT="0.1.1"

DESCRIPTION="QT client for popular in Poland Gadu-Gadu IM network"
HOMEPAGE="http://kadu.net/"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"

IUSE="X debug alsa arts esd voice speech spell nas oss ssl mail extramodules powerkadu kdeenablefinal"

DEPEND="=x11-libs/qt-3*
	media-libs/libsndfile
	>=net-libs/libgadu-1.8.0
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	nas? ( media-libs/nas )
	ssl? ( dev-libs/openssl )
	speech? ( app-accessibility/powiedz )
	spell? ( app-dicts/aspell-pl )"
RDEPEND=${DEPEND}

SRC_URI="http://www.kadu.net/download/stable/${P}.tar.bz2
	extramodules? (
		http://www.kadu.net/~blysk/led_notify-${LED_NOTIFY}.tar.bz2
		http://www.kadu.net/~dorr/moduly/kadu-profiles-${PROFILES}.tar.bz2
		http://www.kadu.net/~dorr/moduly/kadu-osdhints_notify-${OSD_NOTIFY}.tar.bz2
		http://www.kadu.net/~dorr/moduly/kadu-firewall-${FIREWALL}.tar.bz2
		http://kadu.net/~arvenil/tabs/download/${PV}/kadu-tabs-${TABS}.tar.bz2
		http://www.kadu.net/download/modules_extra/filtering/filtering-${FILTERING}.tar.bz2
		http://www.kadu.net/download/modules_extra/screenshot/screenshot-${SCREENSHOT}.tar.bz2
		http://misiek.jah.pl/assets/2008/2/8/agent-${AGENT}.tar.gz )
	powerkadu? (
		http://www.kadu.net/~dorr/moduly/kadu-powerkadu-${POWERKADU}.tar.bz2
		http://kadu.net/~patryk/anonymous_check/anonymous_check-${ANONYM_CHECK}.tar.bz2
		http://www.kadu.net/~dorr/moduly/kadu-antistring-${ANTYSTRING}.tar.bz2
		http://www.kadu.net/~dorr/moduly/kadu-auto_hide-${AUTOHIDE}.tar.bz2
		http://www.kadu.net/~dorr/moduly/kadu-autostatus-${AUTOSTATUS}.tar.bz2
		http://www.kadu.net/~dorr/moduly/kadu-cenzor-${CENZOR}.tar.bz2
		http://www.kadu.net/~dorr/moduly/kadu-split_messages-${SPLITMESG}.tar.bz2
		http://www.kadu.net/~dorr/moduly/kadu-word_fix-${WORDFIX}.tar.bz2
		http://www.kadu.net/~dorr/moduly/kadu-parser_extender-${PARSEREXT}.tar.bz2 )
	mail? (
		http://www.kadu.net/~weagle/mail/mail-${MAIL}.tar.bz2 )
	spell? (
		http://www.kadu.net/download/modules_extra/spellchecker/spellchecker-${SPELLCHECKER}.tar.bz2
	)"

S="${WORKDIR}"/${PN}

enable_module() {
	if use ${1}; then
		mv "${WORKDIR}"/${2} "${WORKDIR}"/kadu/modules/ || die "Error moving module	${2}"
		module_config ${2} m
	fi
}

module_config() {
	sed -i -r "s/(^module_${1}\\s*=\\s*).*/\\1${2}/" .config
}

spec_config() {
	sed -i -r "s/(^${2}\\s*=\\s*).*//" modules/${1}/spec
	echo "${2}=${3}" >> modules/${1}/spec
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Disabling autodownload for modules and icons
	rm -f "${WORKDIR}"/kadu/modules/*.web
	rm -f "${WORKDIR}"/kadu/varia/themes/icons/*.web

	# Disabling all modules and iconsets for further activation via USE flags
	sed .config -i -e 's/=m/=n/g'
	sed .config -i -e 's/=y/=n/g'

	# Enable default icon theme
	sed .config -i -e 's/icons_default=n/icons_default=y/'

	# Enable default emoticon theme
	sed .config -i -e 's/emoticons_penguins=n/emoticons_penguins=y/'

	# Enabling extra modules
	enable_module extramodules agent
	enable_module extramodules osdhints_notify
	enable_module extramodules led_notify
	enable_module extramodules tabs
	enable_module extramodules profiles
	enable_module extramodules firewall
	enable_module extramodules filtering
	enable_module extramodules screenshot

	# Enabling powerkadu and it's dependencies
	enable_module powerkadu powerkadu
	enable_module powerkadu anonymous_check
	enable_module powerkadu antistring
	enable_module powerkadu auto_hide
	enable_module powerkadu autostatus
	enable_module powerkadu cenzor
	enable_module powerkadu split_messages
	enable_module powerkadu word_fix
	enable_module powerkadu parser_extender

	enable_module mail mail
	enable_module spell spellchecker

	use voice && epatch "${FILESDIR}"/voice-gentoo.patch

	epatch "${FILESDIR}"/${P}-kill-strip.patch
	eautoreconf
}

src_compile() {
	filter-flags -fno-rtti

	# Enabling default iconset
	module_config icons_default y

	# Enabling default emoticons
	module_config emoticons_penguins y

	# Enabling dependencies that are needed by other modules
	module_config account_management m
	module_config autoaway m
	module_config autoresponder m
	module_config config_wizard m
	module_config dcc m
	module_config default_sms m
	module_config docking m
	module_config hints m
	module_config notify m
	module_config history m
	module_config sms m
	module_config sound m
	module_config desktop_docking m
	module_config migration m

	use speech && module_config speech m
	use ssl && module_config encryption y
	use alsa && module_config alsa_sound m
	use arts && module_config arts_sound m
	use esd && module_config esd_sound m
	use nas && module_config nas_sound m
	use voice && module_config voice m
	use X && module_config x11_docking m

	# Some fixes
	if use arts; then
		einfo "Fixing modules spec files"
		spec_config arts_sound MODULE_INCLUDES_PATH "\"$(kde-config --prefix)/include $(kde-config --prefix)/include/artsc\""
		spec_config arts_sound MODULE_LIBS_PATH $(kde-config --prefix)/lib
	fi

	local myconf
	myconf="${myconf} --enable-modules --enable-dist-info=Gentoo --enable-pheaders --with-existing-libgadu"
	econf \
		$(use_enable kdeenablefinal final) \
		$(use_enable voice dependency-tracing) \
		$(use_enable debug) \
		${myconf} || die
	emake || die
}

src_install() {
	emake \
		DESTDIR="${D}" \
		install || die
}
