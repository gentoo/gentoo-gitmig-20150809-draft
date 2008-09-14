# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-9999.ebuild,v 1.12 2008/09/14 19:48:27 jokey Exp $

EAPI="1"

inherit cmake-utils multilib subversion

DESCRIPTION="Advanced IRC Client"
HOMEPAGE="http://www.kvirc.net/"

LICENSE="kvirc"
SLOT="4"
KEYWORDS=""
IUSE="audiofile +crypt +dcc_voice debug doc +gsm +ipc ipv6 kde nls profile +qt-dbus qt-phonon qt-webkit ssl +transparency"

RDEPEND="
	sys-libs/zlib
	x11-libs/qt-core
	x11-libs/qt-gui
	x11-libs/qt-qt3support
	audiofile? ( media-libs/audiofile )
	kde? ( kde-base/kdelibs:kde-4 )
	qt-dbus? ( x11-libs/qt-dbus )
	qt-phonon? ( x11-libs/qt-phonon )
	qt-webkit? ( x11-libs/qt-webkit )
	ssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	doc? ( app-doc/doxygen )"

DOCS="ChangeLog TODO"

ESVN_REPO_URI="https://svn.kvirc.de/svn/trunk/kvirc"
ESVN_PROJECT="kvirc"

src_unpack() {
	subversion_src_unpack
	subversion_wc_info
	VERSIO_PRAESENS="${ESVN_WC_REVISION}"
	elog "Setting revision number to ${VERSIO_PRAESENS}"
	sed -i -e "/#define KVI_DEFAULT_FRAME_CAPTION/s/KVI_VERSION/& \" r${VERSIO_PRAESENS}\"/" src/kvirc/ui/kvi_frame.cpp || die "Failed to set revision number"
}

src_compile() {
	local mycmakeargs="
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCOEXISTENCE=1
		-DLIB_INSTALL_PREFIX="/usr/$(get_libdir)"
		-DVERBOSE=1
		$(cmake-utils_use_want audiofile AUDIOFILE)
		$(cmake-utils_use_want crypt CRYPT)
		$(cmake-utils_use_want dcc_voice DCC_VOICE)
		$(cmake-utils_use_want debug DEBUG)
		$(cmake-utils_use_want doc DOXYGEN)
		$(cmake-utils_use_want gsm GSM)
		$(cmake-utils_use_want ipc IPC)
		$(cmake-utils_use_want ipv6 IPV6)
		$(cmake-utils_use_want kde KDE4)
		$(cmake-utils_use_want nls GETTEXT)
		$(cmake-utils_use_want profile MEMORY_PROFILE)
		$(cmake-utils_use_want qt-dbus QTDBUS)
		$(cmake-utils_use_want qt-phonon PHONON)
		$(cmake-utils_use_want qt-webkit QTWEBKIT)
		$(cmake-utils_use_want ssl OPENSSL)
		$(cmake-utils_use_want transparency TRANSPARENCY)"

	cmake-utils_src_compile
}
