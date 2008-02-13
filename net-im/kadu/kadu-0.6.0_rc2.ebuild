# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kadu/kadu-0.6.0_rc2.ebuild,v 1.1 2008/02/13 01:43:35 cla Exp $

inherit flag-o-matic eutils

MY_P=${P/_/-}
MY_PV=${PV/_rc*/}

AGENT="0.4.3"				#http://www.kadu.net/w/Agent
TABS="1.1.1"				#http://www.kadu.net/w/Tabs
SPELLCHECKER="0.21"			#http://scripts.one.pl/spellchecker
LED_NOTIFY="0.13"			#http://http://www.kadu.net/~blysk/
PROFILES="0.3.1"			#http://www.kadu.net/forum/viewtopic.php?t=6282

DESCRIPTION="QT client for popular in Poland Gadu-Gadu IM network"
HOMEPAGE="http://kadu.net/"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="X debug alsa arts esd voice speech nas oss ssl xosd mail kdeenablefinal"

DEPEND="=x11-libs/qt-3*
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	nas? ( media-libs/nas )
	ssl? ( dev-libs/openssl )
	speech? ( app-accessibility/powiedz )
	xosd? ( x11-libs/xosd )"

SRC_URI="http://www.kadu.net/download/stable/${MY_P}.tar.bz2"

# Those need more work
#	 extraicons? (
#		http://banas.ovh.org/wp-content/uploads/2008/01/kadu-themes_0.6.0rc1-1_all.deb
#		)
#
#	extramodules? (
#		http://www.kadu.net/~blysk/led_notify-${LED_NOTIFY}.tar.bz2
#		http://www.kadu.net/~joi/kde_transparency.tar.bz2
#		http://www.kadu.net/~dorr/kadu-profiles-${PROFILES}.tar.bz2
#		http://kadu.net/~arvenil/tabs/download/${MY_PV}/${TABS}/kadu-tabs-${TABS}.tar.bz2
#		http://misiek.jah.pl/assets/2007/12/27/agent-${AGENT}.tar.gz )"

S="${WORKDIR}"/${PN}

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

	use xosd && epatch "${FILESDIR}"/xosd-${MY_PV}-gentoo.patch
	use voice && epatch "${FILESDIR}"/voice-gentoo.patch
}

src_compile() {
	filter-flags -fno-rtti

	# Enabling default iconset
	module_config icons_default y

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

	use xosd && module_config xosd_notify m
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
	myconf="${myconf} --enable-modules --enable-dist-info=Gentoo --enable-pheaders"
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
