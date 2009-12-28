# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-9999.ebuild,v 1.5 2009/12/28 16:58:55 ssuominen Exp $

EAPI="1"

inherit cmake-utils eutils flag-o-matic subversion qt3

ESVN_REPO_URI="svn://svn.berlios.de/sim-im/trunk"
ESVN_PROJECT="sim-im"

DESCRIPTION="Simple Instant Messenger (with KDE support). ICQ/AIM/Jabber/MSN/Yahoo."
HOMEPAGE="http://sim-im.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS=""
IUSE="debug gpg +jabber msn +oscar sms spell ssl weather yahoo livejournal"

# It's possible to disable/enable pluging defining SIMCMAKEOPTS. E.g. put
# SIMCMAKEOPTS="-DENABLE_PLUGIN_TRANSPARENT:BOOL=Off"
# inside /etc/portage/env/net-im/sim to disable transparent plugin.

RDEPEND="
		spell? ( app-text/aspell )
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

src_compile() {
	mycmakeargs="${mycmakeargs}
				$(cmake-utils_use_enable debug PLUGIN_LOGGER)
				$(cmake-utils_use_enable gpg PLUGIN_GPG)
				$(cmake-utils_use_enable jabber PLUGIN_JABBER)
				$(cmake-utils_use_enable livejournal PLUGIN_LIVEJOURNAL)
				$(cmake-utils_use_enable msn PLUGIN_MSN)
				$(cmake-utils_use_enable oscar PLUGIN_ICQ)
				$(cmake-utils_use_enable sms PLUGIN_SMS)
				$(cmake-utils_use_enable spell PLUGIN_SPELL)
				$(cmake-utils_use_enable ssl OPENSSL)
				$(cmake-utils_use_enable weather PLUGIN_WEATHER)
				$(cmake-utils_use_enable yahoo PLUGIN_YAHOO)
				-DENABLE_KDE3=OFF
				-DENABLE_PLUGIN_UPDATE:BOOL=Off
				${SIMCMAKEOPTS}"

	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dodoc TODO TODO.CMake README AUTHORS.sim jisp-resources.txt ChangeLog
}

pkg_postinst() {
	ewarn "Since kde-3.5 is deprecated sim doesn't have kde support any more (#275316)."
	ewarn "If you have used sim built with kde USE flag enabled to migrate on qt only"
	ewarn "version of sim, please, run the following command:"
	ewarn " $ mv ~/.kde3.5/share/apps/sim ~/.sim"
}
