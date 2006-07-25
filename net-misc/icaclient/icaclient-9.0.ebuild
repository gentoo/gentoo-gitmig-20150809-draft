# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icaclient/icaclient-9.0.ebuild,v 1.7 2006/07/25 20:48:29 wolf31o2 Exp $

inherit eutils multilib

DESCRIPTION="ICA Client"
HOMEPAGE="http://www.citrix.com/"
SRC_URI="ICAClient-9.0-1.i386.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="fetch"

RDEPEND="virtual/libc
	|| (
		( x11-libs/libXp
			x11-libs/libXaw
			x11-libs/libX11
			x11-libs/libSM
			x11-libs/libICE )
		 virtual/x11 )
	>=x11-libs/openmotif-2.2.2
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )"
DEPEND="${RDEPEND}
	>=app-arch/rpm-3.0.6"

S="${WORKDIR}/usr"

pkg_setup() {
	# Binary x86 package
	has_multilib_profile && ABI="x86"
}

pkg_nofetch() {
	einfo "Please download ${A} yourself from www.citrix.com"
	einfo "http://www.citrix.com/English/SS/downloads/details.asp?dID=2755&downloadID=3323&pID=186"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	# You must download ICAClient-9.0-1.i386.rpm
	# from www.citrix.com and put it in ${DISTDIR}
	rpm2cpio ${DISTDIR}/${A} | cpio -i --make-directories
}

src_install() {
	dodir /opt/ICAClient
	insinto /opt/ICAClient/.config
	doins lib/ICAClient/.config/*
	insinto /opt/ICAClient
	doins lib/ICAClient/Npica*
	doins lib/ICAClient/*.DLL
	doins lib/ICAClient/Wfcmgr*
	doins lib/ICAClient/Wfica*
	doins lib/ICAClient/eula.txt
	doins lib/ICAClient/npica.so
	doins lib/ICAClient/readme.txt
	doins lib/ICAClient/libctxssl.so
	insinto /opt/ICAClient/cache
	doins lib/ICAClient/cache/*
	insinto /opt/ICAClient/config
	doins lib/ICAClient/config/*
	doins lib/ICAClient/config/.*
	insinto /opt/ICAClient/help
	doins lib/ICAClient/help/*
	insinto /opt/ICAClient/nls
	dosym en /opt/ICAClient/nls/C
	insinto /opt/ICAClient/nls/en
	doins lib/ICAClient/nls/en/*
	insinto /opt/ICAClient/icons
	doins lib/ICAClient/icons/*
	insinto /opt/ICAClient/keyboard
	doins lib/ICAClient/keyboard/*
	insinto /opt/ICAClient/keystore/cacerts
	doins lib/ICAClient/keystore/cacerts/*
	insinto /opt/ICAClient/util
	doins lib/ICAClient/util/{XCapture,XCapture.ad,echo_cmd,icalicense.sh,integrate.sh,nslaunch,pac.js,pacexec,xcapture}
	dosym /opt/ICAClient/util/integrate.sh /opt/ICAClient/util/disintegrate.sh
	exeinto /opt/ICAClient
	doexe lib/ICAClient/wfcmgr
	doexe lib/ICAClient/wfcmgr.bin
	doexe lib/ICAClient/wfica
	insinto /etc/env.d
	doins ${FILESDIR}/10ICAClient
	insinto /usr/$(get_libdir)/nsbrowser/plugins
	dosym /opt/ICAClient/npica.so /usr/$(get_libdir)/nsbrowser/plugins/npica.so

	# The .desktop file included in the rpm links to /usr/lib, so we make a new one
	# The program gives errors and has slowdowns if the locale is not English, so
	# strip it since it has no translations anyway
	doicon lib/ICAClient/icons/*
	make_wrapper wfcmgr 'env LC_ALL="" LANG="" /opt/ICAClient/wfcmgr'
	make_desktop_entry wfcmgr 'Citrix ICA Client' citrix48.xpm
}
