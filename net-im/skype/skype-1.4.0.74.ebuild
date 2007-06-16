# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-1.4.0.74.ebuild,v 1.1 2007/06/16 15:31:20 humpback Exp $

inherit eutils qt4

#If you want to know when this package will be marked stable please see the Changelog
RESTRICT="mirror strip"
AVATARV="1.0"
DESCRIPTION="${PN} is a P2P-VoiceIP client."
MY_PN=${PN}
MY_PV=${PV}
HOMEPAGE="http://www.skype.com/"

SFILENAME=${MY_PN}-${MY_PV}-static.tar.bz2
DFILENAME=${MY_PN}-${MY_PV}.bz2
SRC_URI="
		!static? ( http://download.skype.com/linux/${DFILENAME} )
		static? (
		http://download.skype.com/linux/${SFILENAME} )
		amd64? ( http://felisberto.net/~humpback/libsigc++20-2.0.17-1-from-fc5.rf.i386.tar.gz )"

LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static"
DEPEND="
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2
		>=app-emulation/emul-linux-x86-baselibs-2.1.1
		>=app-emulation/emul-linux-x86-soundlibs-2.4
		app-emulation/emul-linux-x86-compat )
	x86? ( >=sys-libs/glibc-2.4
		>=media-libs/alsa-lib-1.0.11
		>=dev-libs/libsigc++-2
		!static? ( $(qt4_min_version 4.2.3) ) )"
RDEPEND="${DEPEND}
	>=sys-apps/dbus-1.0.0"

QA_EXECSTACK_x86="opt/skype/skype"
QA_EXECSTACK_amd64="opt/skype/skype"

S="${WORKDIR}"/${MY_PN}-${MY_PV}

pkg_setup() {
	if use amd64 && ! use static;
	then
		die "There is no pre-built qt4 for amd64. Please turn the static flag on"
	fi

#	if ! use static && ! built_with_use ">=x11-libs/qt-4.0" accessibility;
#	then
#		eerror "Rebuild qt-4 with USE=accessibility or try again with USE=static"
#		die "USE=-static only works with qt-4 built with USE=accessibility."
#	fi
}

src_unpack() {
	if use static;
	then
		unpack ${SFILENAME}
	else
		unpack ${DFILENAME}
		#Hack around bug in filename
		tar xf skype-1.4.0.74
	fi
	if use amd64;
	then
		unpack libsigc++20-2.0.17-1-from-fc5.rf.i386.tar.gz
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
	make_wrapper skype /opt/${PN}/skype /opt/${PN} /opt/${PN} /usr/bin

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

	#AMD64 team does not provide this so we add it:
	if use amd64; then
		exeinto /opt/${PN}
		dosym libsigc-2.0.so.0.0.0 /opt/${PN}/libsigc-2.0.so.0
		doexe "${WORKDIR}"/libsigc-2.0.so.0.0.0
	fi

	#Ugly hack for bug #179568
	use amd64 && multilib_toolchain_setup x86
	dosym /usr/$(get_libdir)/libdbus-1.so /opt/${PN}/libdbus-1.so.2

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
