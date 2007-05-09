# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-1.4.0.58_alpha.ebuild,v 1.2 2007/05/09 17:09:36 genstef Exp $

inherit eutils qt4


#If you want to know when this package will be marked stable please see the Changelog
RESTRICT="nomirror nostrip"
AVATARV="1.0"
DESCRIPTION="${PN} is a P2P-VoiceIP client."
MY_PN=${PN}
MY_PV=${PV%_alpha}
HOMEPAGE="http://www.skype.com/"
SRC_URI="
		!static? ( http://download.skype.com/linux/${MY_PN}-alpha-${MY_PV}-generic.tar.bz2 )
		static? (
		http://download.skype.com/linux/${MY_PN}-alpha_staticQT-${MY_PV}-generic.tar.bz2 )"

LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static"
DEPEND="
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2
		>=app-emulation/emul-linux-x86-baselibs-2.1.1
		>=app-emulation/emul-linux-x86-soundlibs-2.4
		app-emulation/emul-linux-x86-compat )
	x86? ( >=sys-libs/glibc-2.3.2
		>=media-libs/alsa-lib-1.0.11
		virtual/libstdc++
		!static? ( $(qt4_min_version 4.2.3) ) )"
RDEPEND="${DEPEND}
	>=sys-apps/dbus-0.23.4"

QA_EXECSTACK_x86="opt/skype/skype"
QA_EXECSTACK_amd64="opt/skype/skype"

pkg_setup() {
	if use amd64 && ! use static;
	then
		die "There is no pre-built qt4 for amd64. Please turn the static flag on"
	fi

	if ! use static && ! built_with_use ">=x11-libs/qt-4.0" accessibility;
	then
		eerror "Rebuild qt-4 with USE=accessibility or try again with USE=static"
		die "USE=-static only works with qt-4 built with USE=accessibility."
	fi
}

src_unpack() {
	echo ${MY_PV}
	if use static;
	then
		unpack ${MY_PN}-alpha_staticQT-${MY_PV}-generic.tar.bz2
	else
		unpack ${MY_PN}-alpha-${MY_PV}-generic.tar.bz2
	fi

}

src_install() {
	## Install the wrapper script
	#mv skype skype
	#cp ${FILESDIR}/sDaemonWrapper-r1 skype

	# remove mprotect() restrictions for PaX usage - see Bug 100507
	[[ -x /sbin/chpax ]] && /sbin/chpax -m skype

	dodir /opt/${PN}
	exeopts -m0755
	exeinto /opt/${PN}
	doexe skype
	doexe ${FILESDIR}/skype.sh
	dosym /opt/skype/skype.sh /usr/bin/skype

	#doexe skype-callto-handler
	insinto /opt/${PN}/sounds
	doins sounds/*.wav

	#insinto /opt/${PN}/lang
	#doins lang/*.qm
	#Skype still shows ALL languagues no matter what were installed
	#for i in ${LINGUAS}; do
	#	if [ -f lang/${PN}_${i}.qm ]; then
	#		doins lang/${PN}_${i}.qm
	#	fi;
	#done;
	insinto /etc/dbus-1/system.d
	newins ${FILESDIR}/skype.debus.config skype.conf

	#insinto /opt/${PN}/avatars
	#doins avatars/*.jpg

	#insinto /opt/${PN}
	#for SIZE in 16 32 48
	#do
	#	insinto /usr/share/icons/hicolor/${SIZE}x${SIZE}/apps
	#	newins ${S}/icons/${PN}_${SIZE}_32.png ${PN}.png
	#done

	# The skype icon doesn't show up in gnome for some reason
	# Putting the icon in /usr/share/pixmaps seems to solve it
	#insinto /usr/share/pixmaps
	#newins ${S}/icons/${PN}_48_32.png ${PN}.png

	fowners root:audio /opt/skype/skype
	#fowners root:audio /opt/skype/skype-callto-handler

	#insinto /usr/share/applications/
	#doins skype.desktop

	#dodir /usr/bin/
	# Install the Documentation
	#dodoc README LICENSE


	make_desktop_entry skype "Skype VoIP" skype

	# TODO: Optional configuration of callto:// in KDE, Mozilla and friends
}

pkg_postinst() {
	einfo "If you have sound problems please visit: "
	einfo "http://forum.skype.com/bb/viewtopic.php?t=4489"
	einfo "These kernel options are reported to help"
	einfo "Processor type and features --->"
	einfo "-- Preemption Model (Preemptible Kernel (Low-Latency Desktop))"
	einfo "-- Timer frequency (250 HZ)"
	ewarn ""
	ewarn "This release no longer uses the old wrapper because skype now uses
	ALSA"
	ewarn ""

}
