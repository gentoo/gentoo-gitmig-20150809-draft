# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-9999.ebuild,v 1.3 2008/05/11 13:24:42 pva Exp $

EAPI="1"

inherit cmake-utils kde-functions eutils flag-o-matic subversion

ESVN_REPO_URI="svn://svn.berlios.de/sim-im/trunk"
ESVN_PROJECT="sim-im"

DESCRIPTION="Simple Instant Messenger (with KDE support). ICQ/AIM/Jabber/MSN/Yahoo."
HOMEPAGE="http://sim-im.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug gpg +jabber kde msn +oscar sms spell ssl weather yahoo livejournal"

# It's possible to disable/enable pluging defining SIMCMAKEOPTS. E.g. put
# SIMCMAKEOPTS="-DENABLE_PLUGIN_TRANSPARENT:BOOL=Off"
# inside /etc/portage/env/net-im/sim to disable transparent plugin.

# kdebase-data provides the icon "licq.png"
RDEPEND="kde? ( kde-base/kdelibs:3.5
				|| ( kde-base/kdebase-data:3.5 kde-base/kdebase:3.5 ) )
		!kde? ( spell? ( app-text/aspell ) )
		x11-libs/qt:3
		ssl? ( dev-libs/openssl )
		gpg? ( app-crypt/gnupg )
		dev-libs/libxml2
		dev-libs/libxslt
		sys-libs/zlib
		media-libs/fontconfig
		x11-libs/libXScrnSaver"

DEPEND="${RDEPEND}
		sys-devel/flex
		app-arch/zip
		x11-proto/scrnsaverproto"

pkg_setup() {
	if use kde; then
		if use spell; then
			if ! built_with_use "kde-base/kdelibs:3.5" spell; then
				ewarn "kde-base/kdelibs were merged without spell in USE."
				ewarn "Thus spelling will not work in sim. Please, either"
				ewarn "reemerge kde-base/kdelibs with spell in USE or emerge"
				ewarn 'sim with USE="-spell" to avoid this message.'
				ebeep
			fi
		else
			if built_with_use "kde-base/kdelibs:3.5" spell; then
				ewarn 'kde-base/kdelibs were merged with spell in USE.'
				ewarn 'Thus spelling will work in sim. Please, either'
				ewarn 'reemerge kde-base/kdelibs without spell in USE or emerge'
				ewarn 'sim with USE="spell" to avoid this message.'
				ebeep
			fi
		fi
	fi
	if ! use jabber && ! use livejournal && ! use msn && ! use oscar && ! use yahoo; then
		eerror "Sim requires at least one instant messaging protocol to be"
		eerror "activated. The available protocols are:"
		eerror "\"jabber livejournal msn oscar yahoo\"."
		die "No instant messaging protocol activated."
	fi
}

src_compile() {
	if use kde; then
		set-kdedir 3
	fi
	mycmakeargs="${mycmakeargs}
				$(cmake-utils_use_enable debug PLUGIN_LOGGER)
				$(cmake-utils_use_enable gpg PLUGIN_GPG)
				$(cmake-utils_use_enable jabber PLUGIN_JABBER)
				$(cmake-utils_use_enable livejournal PLUGIN_LIVEJOURNAL)
				$(cmake-utils_use_enable kde KDE3)
				$(cmake-utils_use_enable msn PLUGIN_MSN)
				$(cmake-utils_use_enable oscar PLUGIN_ICQ)
				$(cmake-utils_use_enable sms PLUGIN_SMS)
				$(cmake-utils_use_enable spell PLUGIN_SPELL)
				$(cmake-utils_use_enable ssl OPENSSL)
				$(cmake-utils_use_enable weather PLUGIN_WEATHER)
				$(cmake-utils_use_enable yahoo PLUGIN_YAHOO)
				-DENABLE_PLUGIN_UPDATE:BOOL=Off
				${SIMCMAKEOPTS}"

	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dodoc TODO TODO.CMake README AUTHORS.sim jisp-resources.txt ChangeLog
}
