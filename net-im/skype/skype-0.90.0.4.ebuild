# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-0.90.0.4.ebuild,v 1.1 2004/06/24 13:59:24 humpback Exp $

inherit eutils

SVER=${PV//./_}
RESTRICT="fetch"
DESCRIPTION="${PN} is a P2P-VoiceIP client."
HOMEPAGE="http://www.${PN}.com/"
SRC_URI="
		qt? ( ${PN}_ver-${SVER}.tar.bz2 )
		!qt? ( ${PN}_ver-${SVER}-staticQT.tar.bz2 )"
LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~x86"
IUSE="qt arts esd"
DEPEND="qt? ( >=x11-libs/qt-3.2 )
		>=sys-libs/glibc-2.2.5"
S="${WORKDIR}/${PN}_ver-${SVER}"

pkg_nofetch() {
	einfo "Please go to http://www.skype.com/download_linux.html and download"
	if use !qt;
	then
		einfo "the static binary tar.bz2"
	else
		einfo "the dynamic binary tar.bz2"
	fi
	einfo "and copy it to ${DISTDIR}"
	einfo ""
	einfo "Have a look at ${PORTDIR}/licenses/${LICENSE} before running this software"
}

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
	insinto /opt/skype
	doins call_in.wav
	make_desktop_entry skype "Skype VoIP" ../icons/hicolor/48x48/apps/skype.png "Telephony"
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
