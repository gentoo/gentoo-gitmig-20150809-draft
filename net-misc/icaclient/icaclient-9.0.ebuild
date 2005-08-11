# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icaclient/icaclient-9.0.ebuild,v 1.3 2005/08/11 20:34:55 flameeyes Exp $

inherit multilib

DESCRIPTION="ICA Client"
HOMEPAGE="http://www.citrix.com/site/SS/downloads/details.asp?dID=2755&downloadID=3323"
SRC_URI="ICAClient-9.0-1.i386.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE="gnome"
RESTRICT="fetch"

RDEPEND="virtual/libc
	virtual/x11
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

	if use gnome; then
		insinto /usr/share/applications
		doins lib/ICAClient/desktop/*.desktop
	fi
}
