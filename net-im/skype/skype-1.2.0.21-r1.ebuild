# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-1.2.0.21-r1.ebuild,v 1.5 2007/07/12 05:34:47 mr_bones_ Exp $

inherit eutils qt3 rpm

#If you want to know when this package will be marked stable please see the Changelog
RESTRICT="mirror strip"
AVATARV="1.0"
DESCRIPTION="${PN} is a P2P-VoiceIP client."
HOMEPAGE="http://www.${PN}.com/"
SRC_URI="http://dev.gentoo.org/~humpback/skype-avatars-${AVATARV}.tgz
		http://download.skype.com/linux/${P}-1mdk.i586.rpm"
LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static arts esd"
DEPEND="
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2
		>=app-emulation/emul-linux-x86-baselibs-2.1.1
		!static? ( >=app-emulation/emul-linux-x86-qtlibs-1.1 ) )
	x86? ( >=sys-libs/glibc-2.3.2 )"
RDEPEND="${DEPEND}
	>=sys-apps/dbus-0.23.4"

src_unpack() {
	rpm_unpack ${DISTDIR}/${P}-1mdk.i586.rpm
	cd ${WORKDIR}/usr/share
	unpack skype-avatars-${AVATARV}.tgz
}

src_install() {
	## Install the wrapper script
	cd ${WORKDIR}/usr/share
	mv ${WORKDIR}/usr/bin/skype skype.bin
	mv ${WORKDIR}/etc/dbus-1/system.d/skype.conf skype.conf
	mv applications/skype.desktop skype.desktop
	mv skype/* .
	mv doc/${P}/LICENSE LICENSE
	mv doc/${P}/README README
	mkdir ${WORKDIR}/temp
	cp pixmaps/skype.png ${WORKDIR}/temp/skype.png
	rm -rf skype
	cp ${FILESDIR}/sDaemonWrapper-r1 skype
	cp ${FILESDIR}/skype-callto-handler skype-callto-handler

	dodir /opt/${PN}
	exeopts -m0755
	exeinto /opt/${PN}
	doexe skype
	doexe skype.bin
	doexe skype-callto-handler
	insinto /opt/${PN}/sound
	doins sound/*.wav
	cd ${WORKDIR}/usr/share
	insinto /opt/${PN}/lang
	doins lang/*.qm
	cd ${WORKDIR}/usr/share
	#Skype still shows ALL languagues no matter what were installed
	#for i in ${LINGUAS}; do
	#	if [ -f lang/${PN}_${i}.qm ]; then
	#		doins lang/${PN}_${i}.qm
	#	fi;
	#done;
	insinto /etc/dbus-1/system.d
	cd ${WORKDIR}/usr/share
	doins skype.conf

	insinto /opt/${PN}/avatars
	cd ${WORKDIR}/usr/share
	doins avatars/*.jpg

	insinto /opt/${PN}
	cd ${WORKDIR}/usr/share
	make_desktop_entry skype "Skype VoIP" skype
	insinto /usr/share/pixmaps
	doins pixmaps/skype.png

	cd ${WORKDIR}/usr/share
#	for SIZE in 16 32 48
#	do
#		insinto /usr/share/icons/hicolor/${SIZE}x${SIZE}/apps
#		newins ${WORKDIR}/usr/share/icons/${PN}_${SIZE}_32.png ${PN}.png
#	done
	fowners root:audio /opt/skype/skype.bin
	fowners root:audio /opt/skype/skype
	fowners root:audio /opt/skype/skype-callto-handler
	dodir /usr/bin/
	dosym /opt/skype/skype /usr/bin/skype
	# Install the Documentation
	cd ${WORKDIR}/usr/share
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
