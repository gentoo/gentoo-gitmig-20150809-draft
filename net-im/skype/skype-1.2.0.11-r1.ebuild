# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-1.2.0.11-r1.ebuild,v 1.1 2005/08/16 14:15:19 humpback Exp $

inherit eutils qt3


#If you want to know when this package will be marked stable please see the Changelog
RESTRICT="nomirror"
AVATARV="1.0"
DESCRIPTION="${PN} is a P2P-VoiceIP client."
HOMEPAGE="http://www.${PN}.com/"
SRC_URI="http://dev.gentoo.org/~humpback/skype-avatars-${AVATARV}.tgz
		!static? ( http://download.skype.com/linux/${P}.tar.bz2 )
		static? ( http://download.skype.com/linux/${PN}_staticQT-${PV}.tar.bz2 )"
LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static arts esd"
DEPEND="
	amd64? ( app-emulation/emul-linux-x86-glibc
		>=app-emulation/emul-linux-x86-xlibs-1.2
		>=app-emulation/emul-linux-x86-baselibs-2.1.1
		!static? ( >=app-emulation/emul-linux-x86-qtlibs-1.1 ) )
	x86? ( !static? ( $(qt_min_version 3.2) )
		>=sys-libs/glibc-2.3.2 )"
RDEPEND="${DEPEND}
	>=sys-apps/dbus-0.23.4"

src_unpack() {
	if use static;
		then
		unpack ${PN}_staticQT-${PV}.tar.bz2
		mv ${PN}_staticQT-${PV} ${S}
	else
		unpack ${P}.tar.bz2
	fi
	cd ${P}
	unpack skype-avatars-${AVATARV}.tgz
}

src_install() {
	## Install the wrapper script
	mv skype skype.bin
	cp ${FILESDIR}/sDaemonWrapper-r1 skype

	dodir /opt/${PN}
	exeopts -m0755
	exeinto /opt/${PN}
	doexe skype
	doexe skype.bin
	doexe skype-callto-handler
	insinto /opt/${PN}/sound
	doins sound/*.wav

	insinto /opt/${PN}/lang
	doins lang/*.qm
	#Skype still shows ALL languagues no matter what were installed
	#for i in ${LINGUAS}; do
	#	if [ -f lang/${PN}_${i}.qm ]; then
	#		doins lang/${PN}_${i}.qm
	#	fi;
	#done;
	insinto /etc/dbus-1/system.d
	doins skype.conf

	insinto /opt/${PN}/avatars
	doins avatars/*.jpg

	insinto /opt/${PN}
	make_desktop_entry skype "Skype VoIP" skype
	for SIZE in 16 32 48
	do
		insinto /usr/share/icons/hicolor/${SIZE}x${SIZE}/apps
		newins ${S}/icons/${PN}_${SIZE}_32.png ${PN}.png
	done
	fowners root:audio /opt/skype/skype.bin
	fowners root:audio /opt/skype/skype
	fowners root:audio /opt/skype/skype-callto-handler
	dodir /usr/bin/
	dosym /opt/skype/skype /usr/bin/skype
	# Install the Documentation
	dodoc README LICENSE

	# TODO: Optional configuration of callto:// in KDE, Mozilla and friends
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
	ewarn "If you are upgrading and skype does not autologin do a manual login"
	ewarn "you will not lose your contacts."
}
