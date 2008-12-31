# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-9999.ebuild,v 1.17 2008/12/31 03:39:18 mr_bones_ Exp $

EAPI="2"

inherit cmake-utils multilib subversion

DESCRIPTION="Advanced IRC Client"
HOMEPAGE="http://www.kvirc.net/"
SRC_URI=""
ESVN_REPO_URI="https://svn.kvirc.de/svn/trunk/kvirc"
ESVN_PROJECT="kvirc"

LICENSE="kvirc"
SLOT="4"
KEYWORDS=""
IUSE="audiofile +crypt +dcc_voice debug doc +gsm +ipc ipv6 kde +nls profile
+phonon +qt-dbus qt-webkit +ssl +transparency"

RDEPEND="
	sys-libs/zlib
	x11-libs/qt-gui
	audiofile? ( media-libs/audiofile )
	kde? ( >=kde-base/kdelibs-3.9 )
	phonon? ( || ( media-sound/phonon x11-libs/qt-phonon ) )
	qt-dbus? ( x11-libs/qt-dbus )
	qt-webkit? ( x11-libs/qt-webkit )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

DOCS="ChangeLog TODO"

src_unpack() {
	local VERSIO_PRAESENS

	subversion_src_unpack
	subversion_wc_info
	VERSIO_PRAESENS="${ESVN_WC_REVISION}"
	elog "Setting revision number to ${VERSIO_PRAESENS}"
	sed -i \
		-e "/#define KVI_DEFAULT_FRAME_CAPTION/s/KVI_VERSION/& \" r${VERSIO_PRAESENS}\"/" \
		src/kvirc/ui/kvi_frame.cpp || die "Failed to set revision number"
}

src_configure() {
	local libdir="$(get_libdir)"
	local mycmakeargs="
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCOEXISTENCE=1
		-DLIB_SUFFIX=${libdir#lib}
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
		$(cmake-utils_use_want phonon PHONON)
		$(cmake-utils_use_want profile MEMORY_PROFILE)
		$(cmake-utils_use_want qt-dbus QTDBUS)
		$(cmake-utils_use_want qt-webkit QTWEBKIT)
		$(cmake-utils_use_want ssl OPENSSL)
		$(cmake-utils_use_want transparency TRANSPARENCY)"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	mv "${D}"/usr/share/man/man1/kvirc.1 \
		"${D}"/usr/share/man/man1/kvirc4.1 || die "mv kvirc.1 failed"

	elog "In order to keep kvirc4 and kvirc3 working both side-by-side"
	elog "man pages for ${P} are under \"man kvirc4\""
}
