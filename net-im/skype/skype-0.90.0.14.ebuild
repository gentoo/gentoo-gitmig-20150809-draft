# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-0.90.0.14.ebuild,v 1.2 2004/07/25 13:53:05 humpback Exp $

inherit eutils

SVER=${PV//./_}
RESTRICT="nomirror"
DESCRIPTION="${PN} is a P2P-VoiceIP client."
HOMEPAGE="http://www.${PN}.com/"
SRC_URI="
		qt? ( http://download.skype.com/linux/${PN}_ver-${SVER}.tar.bz2 )
		!qt? ( http://download.skype.com/linux/${PN}_ver-${SVER}-staticQT.tar.bz2 )"
LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~x86"
IUSE="qt arts esd"
DEPEND="qt? ( >=x11-libs/qt-3.2 )
		>=sys-libs/glibc-2.2.5"
S="${WORKDIR}/${PN}_ver-${SVER}"

src_unpack() {
	if use !qt;
		then
		unpack ${PN}_ver-${SVER}-staticQT.tar.bz2
		cd ${WORKDIR}
		mv ${PN}_ver-${SVER}-staticQT ${PN}_ver-${SVER}
		cd ${S}
	else
		unpack ${PN}_ver-${SVER}.tar.bz2
		cd ${S}
	fi
}

src_install() {
	## Install the wrapper script
	if ( use arts  ||  use esd );
	then
		mv skype skype.bin
		cp ${FILESDIR}/sDaemonWrapper skype
	fi

	dodir /opt/skype
	exeopts -m0755
	exeinto /opt/skype
	doexe skype
	( use arts || use esd ) && doexe skype.bin
	#It seems skype wants the wave in /usr/share/skype
	#http://forum.skype.com/bb/viewtopic.php?t=4145
	insinto /usr/share/skype
	doins call_in.wav
	insinto /opt/skype
	make_desktop_entry skype "Skype VoIP" ../icons/hicolor/48x48/apps/skype.png
	for SIZE in 16 24 32 48
	do
		mkdir ${S}/icons/${SIZE}
		cp ${S}/icons/${PN}_${SIZE}_32.png ${S}/icons/${SIZE}/${PN}.png
		dodir /usr/share/icons/hicolor/${SIZE}x${SIZE}/apps
		insinto /usr/share/icons/hicolor/${SIZE}x${SIZE}/apps
		doins ${S}/icons/${SIZE}/${PN}.png
	done
	( use arts || use esd ) && fowners root:audio /opt/skype/skype.bin
	fowners root:audio /opt/skype/skype
	dodir /usr/bin/
	dosym /opt/skype/skype /usr/bin/skype
}

pkg_postinst() {
	einfo "Have a look at ${PORTDIR}/licenses/${LICENSE} before running this software"
	einfo "If you have sound problems please visit: "
	einfo "http://forum.skype.com/bb/viewtopic.php?t=4489"
	if ( use arts );
	then
		ewarn "Dont forget to configure your arts to work in Full-Duplex mode"
		ewarn "Open controlcenter, go to \"Sound & Multimedia\"->\"Sound System\""
		ewarn "On the \"Hardware\" tab, check the box next to \"Full duplex\"."
	fi
}
