# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-0.93.0.3-r3.ebuild,v 1.1 2005/01/05 22:24:11 humpback Exp $

inherit eutils


#If you want to know when this package will be marked stable please see the Changelog
RESTRICT="nomirror"
AVATARV="1.0"
DESCRIPTION="${PN} is a P2P-VoiceIP client."
HOMEPAGE="http://www.${PN}.com/"
SRC_URI="http://www.gentoo-pt.org/~humpback/skype-avatars-${AVATARV}.tgz
		!static? ( http://download.skype.com/linux/${P}.tar.bz2 )
		static? ( http://download.skype.com/linux/${PN}_staticQT-${PV}.tar.bz2 )"
LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static arts esd"
DEPEND="amd64? ( app-emulation/emul-linux-x86-glibc
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-baselibs
		!static? ( app-emulation/emul-linux-x86-qtlibs )
	)
	x86? ( !static? ( >=x11-libs/qt-3.2 )
		>=sys-libs/glibc-2.2.5
	)"

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
	cp ${FILESDIR}/sDaemonWrapper skype

	dodir /opt/skype
	exeopts -m0755
	exeinto /opt/skype
	doexe skype
	doexe skype.bin
	#This version nolonger has the need for resources hardcoded it can use
	#./skype --resources-path /some/directory/with/resources but our script
	#must be changed and the older ebuilds removed first
	insinto /opt/skype/sound
	doins sound/*.wav

	insinto /opt/skype/lang
	doins lang/*.qm
	#Skype still shows ALL languagues no matter what were installed
	#for i in ${LINGUAS}; do
	#	if [ -f lang/${PN}_${i}.qm ]; then
	#		doins lang/${PN}_${i}.qm
	#	fi;
	#done;

	insinto /opt/skype/avatars
	doins avatars/*.jpg

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
	fowners root:audio /opt/skype/skype.bin
	fowners root:audio /opt/skype/skype
	dodir /usr/bin/
	dosym /opt/skype/skype /usr/bin/skype
	# Install the Documentation
	dodoc README LICENSE
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
