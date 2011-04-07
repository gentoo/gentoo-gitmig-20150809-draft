# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-2.2.0.25.ebuild,v 1.1 2011/04/07 09:24:46 scarabeus Exp $

EAPI=4
inherit gnome2-utils eutils qt4-r2 pax-utils

SFILENAME=${PN}_static-${PV}.tar.bz2
DFILENAME=${P}.tar.bz2

DESCRIPTION="A P2P-VoiceIP client."
HOMEPAGE="http://www.skype.com/"
SRC_URI="!qt-static? ( http://download.skype.com/linux/${DFILENAME} )
	qt-static? ( http://download.skype.com/linux/${SFILENAME} )"

LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt-static"

RESTRICT="mirror strip" # Bug 299368
EMUL_VER=20091231

RDEPEND="
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-${EMUL_VER}
			>=app-emulation/emul-linux-x86-baselibs-${EMUL_VER}
			>=app-emulation/emul-linux-x86-soundlibs-${EMUL_VER}
			>=app-emulation/emul-linux-x86-opengl-${EMUL_VER}
			!qt-static? ( >=app-emulation/emul-linux-x86-qtlibs-${EMUL_VER} ) )
	x86? ( >=media-libs/alsa-lib-1.0.11
		x11-libs/libXScrnSaver
		x11-libs/libXv
		qt-static? ( media-libs/alsa-lib
			x11-libs/libXv
			x11-libs/libXScrnSaver
			x11-libs/libSM
			x11-libs/libICE
			x11-libs/libXi
			x11-libs/libXrender
			x11-libs/libXrandr
			media-libs/freetype
			media-libs/fontconfig
			x11-libs/libXext
			x11-libs/libX11
			dev-libs/glib:2 )
		!qt-static? ( media-libs/alsa-lib
			x11-libs/libXv
			x11-libs/libXScrnSaver
			x11-libs/qt-gui:4[accessibility,dbus]
			x11-libs/qt-dbus:4
			x11-libs/libXext
			x11-libs/libX11 ) )
	virtual/ttf-fonts"

# Required for lrelease command at buildtime
DEPEND="!qt-static? ( x11-libs/qt-core:4 )"

QA_EXECSTACK="opt/skype/skype"
QA_WX_LOAD="opt/skype/skype"
QA_DT_HASH="opt/skype/skype"
# QA_PRESTRIPPED="opt/skype/skype"

pkg_setup() {
	:
}

src_install() {
	local MY_S="${S}"
	use qt-static && MY_S="${WORKDIR}/${PN}_static-${PV}"
	cd "${MY_S}"

	exeinto /opt/skype
	doexe skype || die
	fowners root:audio /opt/skype/skype
	make_wrapper skype ./skype /opt/skype /opt/skype

	insinto /opt/skype/sounds
	doins sounds/*.wav || die

	if ! use qt-static; then
		insinto /etc/dbus-1/system.d
		doins skype.conf || die
	fi

	if ! use qt-static; then
		lrelease lang/*.ts
	fi

	insinto /opt/skype/lang
	doins lang/*.qm || die

	insinto /opt/skype/avatars
	doins avatars/*.png || die

	local res
	for res in 16 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins icons/SkypeBlue_${res}x${res}.png skype.png || die
	done

	dodoc README

	make_desktop_entry skype "Skype VoIP" skype "Network;InstantMessaging;Telephony"

	dosym /opt/skype /usr/share/skype #Fix for disabled sound notification
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
