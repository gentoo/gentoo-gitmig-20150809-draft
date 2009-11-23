# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-4.0_pre3566.ebuild,v 1.2 2009/11/23 13:54:53 maekke Exp $

EAPI="2"

inherit cmake-utils multilib

DESCRIPTION="Advanced IRC Client"
HOMEPAGE="http://www.kvirc.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="kvirc"
SLOT="4"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86"
IUSE="audiofile +crypt +dcc_voice debug doc gsm +ipc ipv6 kde +nls oss +perl +phonon profile +python +qt-dbus qt-webkit +ssl +transparency"

RDEPEND="
	sys-libs/zlib
	>=x11-libs/qt-core-4.5
	>=x11-libs/qt-gui-4.5
	>=x11-libs/qt-sql-4.5
	kde? ( >=kde-base/kdelibs-4 )
	oss? ( audiofile? ( media-libs/audiofile ) )
	perl? ( dev-lang/perl )
	phonon? ( || ( media-sound/phonon >=x11-libs/qt-phonon-4.5 ) )
	python? ( dev-lang/python )
	qt-dbus? ( >=x11-libs/qt-dbus-4.5 )
	qt-webkit? ( >=x11-libs/qt-webkit-4.5 )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.4
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"
RDEPEND="${RDEPEND}
	gsm? ( media-sound/gsm )"

DOCS="ChangeLog TODO"

pkg_setup() {
	if use audiofile && ! use oss; then
		die "USE=\"audiofile\" requires USE=\"oss\""
	fi
}

src_prepare() {
	VERSIO_PRAESENS="${PV#*_pre}"
	elog "Setting revision number to ${VERSIO_PRAESENS}"
	sed -e "/#define KVI_DEFAULT_FRAME_CAPTION/s/KVI_VERSION/& \" r${VERSIO_PRAESENS}\"/" -i src/kvirc/ui/kvi_frame.cpp || die "Failed to set revision number"
}

src_configure() {
	local libdir="$(get_libdir)"
	local mycmakeargs="
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCOEXISTENCE=1
		-DLIB_SUFFIX=${libdir#lib}
		-DMANUAL_REVISION=${VERSIO_PRAESENS}
		-DUSE_ENV_FLAGS=1
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
		$(cmake-utils_use_want oss OSS)
		$(cmake-utils_use_want perl PERL)
		$(cmake-utils_use_want phonon PHONON)
		$(cmake-utils_use_want profile MEMORY_PROFILE)
		$(cmake-utils_use_want python PYTHON)
		$(cmake-utils_use_want qt-dbus QTDBUS)
		$(cmake-utils_use_want qt-webkit QTWEBKIT)
		$(cmake-utils_use_want ssl OPENSSL)
		$(cmake-utils_use_want transparency TRANSPARENCY)"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	mv "${D}"usr/share/man/man1/kvirc.1 "${D}"usr/share/man/man1/kvirc4.1 || die "mv kvirc.1 failed"

	elog "In order to keep KVIrc 4 and KVIrc3 working both side-by-side"
	elog "man page for ${P} is under \"man kvirc4\""
}

pkg_preinst() {
	if has_version "=${CATEGORY}/${PN}-4.0_pre3412"; then
		log_location_change="1"
	fi
}

pkg_postinst() {
	if [[ "${log_location_change}" == "1" ]]; then
		elog "Default location of logs has changed back from ~/log to ~/.config/KVIrc/log."
		elog "You might want to run the following command to restore default location:"
		elog "   sed -e \"/^stringLogsPath=/d\" -i ~/.config/KVIrc/config/main.kvc"
		elog "You can also set location of logs in KVIrc configuration."
		ebeep 12
	fi
}
