# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-0.92.0.12.ebuild,v 1.1 2004/11/19 17:02:45 humpback Exp $

inherit eutils


#If you want to know when this package will be marked stable please see the Changelog
RESTRICT="nomirror"
DESCRIPTION="${PN} is a P2P-VoiceIP client."
HOMEPAGE="http://www.${PN}.com/"
SRC_URI="
		qt? ( http://download.skype.com/linux/${P}.tar.bz2 )
		!qt? ( http://download.skype.com/linux/${PN}_staticQT-${PV}.tar.bz2 )"
LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="qt arts esd"
DEPEND="amd64? ( app-emulation/emul-linux-x86-glibc
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-baselibs
		qt? ( app-emulation/emul-linux-x86-qtlibs )
	)
	x86? ( qt? ( >=x11-libs/qt-3.2 )
		>=sys-libs/glibc-2.2.5
	)"

src_unpack() {
	if use !qt;
		then
		unpack ${PN}_staticQT-${PV}.tar.bz2
		mv ${PN}_staticQT-${PV} ${S}
	else
		unpack ${P}.tar.bz2
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
	insinto /usr/share/skype/lang
	doins *.qm
	insinto /opt/skype
	make_desktop_entry skype "Skype VoIP" ../icons/hicolor/48x48/apps/skype.png
	for SIZE in 16 32 48
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
	##I do not know if this is true for this version. But will leave the note here
	ewarn "There are some problems with this version of skype when upgrading"
	ewarn "If you have problems please go to:"
	ewarn "http://forum.skype.com/bb/viewtopic.php?t=7187"
}
