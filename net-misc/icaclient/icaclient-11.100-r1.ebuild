# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icaclient/icaclient-11.100-r1.ebuild,v 1.2 2010/10/10 18:02:16 ulm Exp $

EAPI=1

inherit eutils multilib rpm

DESCRIPTION="ICA Client for Citrix Presentation servers"
HOMEPAGE="http://www.citrix.com/"
# There is no direct download link from upstream, see pkg_nofetch()
SRC_URI="ICAClient-11.100-1.i386.rpm"

LICENSE="icaclient"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="nsplugin linguas_de linguas_ja"
RESTRICT="mirror strip userpriv fetch"

QA_TEXTRELS="opt/ICAClient/VDSCARD.DLL
	opt/ICAClient/TW1.DLL
	opt/ICAClient/NDS.DLL
	opt/ICAClient/CHARICONV.DLL
	opt/ICAClient/PDCRYPT1.DLL
	opt/ICAClient/VDCM.DLL
	opt/ICAClient/libctxssl.so
	opt/ICAClient/PDCRYPT2.DLL
	opt/ICAClient/npica.so
	opt/ICAClient/VDSPMIKE.DLL"
QA_EXECSTACK="opt/ICAClient/wfica.bin
	opt/ICAClient/libctxssl.so"

RDEPEND="x11-terms/xterm
	media-fonts/font-adobe-100dpi
	media-fonts/font-misc-misc
	media-fonts/font-cursor-misc
	media-fonts/font-xfree86-type1
	media-fonts/font-misc-ethiopic
	x86? (
		x11-libs/libXp
		x11-libs/libXaw
		x11-libs/libX11
		x11-libs/libSM
		x11-libs/libICE
		>=x11-libs/openmotif-2.3.1:0
	)
	amd64? (
		>=app-emulation/emul-linux-x86-xlibs-20080316
		nsplugin? (
			www-plugins/nspluginwrapper
		)
	)"
DEPEND=""
S="${WORKDIR}/usr/lib/ICAClient"

pkg_setup() {
	# Binary x86 package
	has_multilib_profile && ABI="x86"
}

pkg_nofetch() {
	elog "Download the client RPM file ${SRC_URI} from http://www.citrix.com/English/SS/downloads/details.asp?downloadID=3323"
	elog "and place it in ${DISTDIR:-/usr/portage/distfiles}."
}

src_install() {
	dodir /opt/ICAClient

	insinto /opt/ICAClient
	if use nsplugin
	then
		doins npica.so
	fi
	doins *.DLL libctxssl.so libproxy.so nls/en/eula.txt

	insinto /opt/ICAClient/config
	doins config/* config/.* nls/en/*.ini

	insinto /opt/ICAClient/config/usertemplate
	doins config/usertemplate/*

	insinto /opt/ICAClient/nls
	dosym en /opt/ICAClient/nls/C

	insinto /opt/ICAClient/nls/en
	doins nls/en/*

	insinto /opt/ICAClient/nls/en/UTF-8
	doins nls/en/UTF-8/*

	if use linguas_de; then
		insinto /opt/ICAClient/nls/de
		doins nls/de/*

		insinto /opt/ICAClient/nls/de/UTF-8
		doins nls/de/UTF-8/*
	fi
	if use linguas_ja; then
		insinto /opt/ICAClient/nls/ja
		doins nls/ja/*

		insinto /opt/ICAClient/nls/ja/UTF-8
		doins nls/ja/UTF-8/*
	fi

	insinto /opt/ICAClient/icons
	doins icons/*

	insinto /opt/ICAClient/keyboard
	doins keyboard/*

	insinto /opt/ICAClient/keystore/cacerts
	doins keystore/cacerts/*

	insinto /opt/ICAClient/util
	doins util/{echo_cmd,gst_play,icalicense.sh,integrate.sh,libgstflatstm.so,nslaunch,pacexec,pac.js,sunraymac.sh,what,xcapture}
	dosym /opt/ICAClient/util/integrate.sh /opt/ICAClient/util/disintegrate.sh

	doenvd "${FILESDIR}"/10ICAClient

	if use nsplugin
	then
		dosym /opt/ICAClient/npica.so /usr/$(get_libdir)/nsbrowser/plugins/npica.so
	fi

	# wfica has libxcb locking bugs, so provide a wrapper.  It needs to be in
	# /opt/ICAClient to ensure it gets called, so rename wfica to wfica.bin.
	sed -e "/^ICAROOT.*$/d" -i wfica.sh || die
	exeinto /opt/ICAClient
	doexe wfcmgr.bin wfica_assoc.sh wfica.sh util/wfcmgr
	newexe wfica wfica.bin
	make_wrapper wfica 'env LC_ALL="" LANG="" LIBXCB_ALLOW_SLOPPY_LOCK=1 /opt/ICAClient/wfica.bin' . /opt/ICAClient /opt/ICAClient

	# The .desktop file included in the rpm links to /usr/lib, so we
	# make a new one.  The program gives errors and has slowdowns if
	# the locale is not English, so strip it since it has no
	# translations anyway
	doicon icons/*
	make_wrapper wfcmgr /opt/ICAClient/wfcmgr . /opt/ICAClient
	sed -e  's:^\# Configuration items.*:. /opt/ICAClient/nls/en/wfcmgr.msg:g' -i "${D}"/opt/ICAClient/wfcmgr
	make_desktop_entry wfcmgr 'Citrix ICA Client' manager

	dodir /etc/revdep-rebuild/
	echo "SEARCH_DIRS_MASK=/opt/ICAClient" > "${D}"/etc/revdep-rebuild/70icaclient
}
