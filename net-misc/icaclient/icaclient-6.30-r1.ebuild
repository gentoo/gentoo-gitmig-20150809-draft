# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icaclient/icaclient-6.30-r1.ebuild,v 1.9 2004/11/24 21:56:17 swegener Exp $

DESCRIPTION="ICA Client"
HOMEPAGE="http://www.citrix.com/download/unix-downloads.asp"
SRC_URI="ICAClient-6.30-1.i386.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 -sparc"
IUSE=""
RESTRICT="fetch"

RDEPEND="virtual/libc
	virtual/x11"
DEPEND="${RDEPEND}
	>=app-arch/rpm-3.0.6"

S="${WORKDIR}/usr"

pkg_nofetch() {
	einfo "Please download ${A} yourself from www.citrix.com"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	# You must download ICAClient-6.30-1.i386.rpm
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
	insinto /opt/ICAClient/cache
	doins lib/ICAClient/cache/*
	insinto /opt/ICAClient/config
	doins lib/ICAClient/config/*
	insinto /opt/ICAClient/help
	doins lib/ICAClient/help/*
	insinto /opt/ICAClient/icons
	doins lib/ICAClient/icons/*
	insinto /opt/ICAClient/keyboard
	doins lib/ICAClient/keyboard/*
	insinto /opt/ICAClient/keystore/cacerts
	doins lib/ICAClient/keystore/cacerts/*
	insinto /opt/ICAClient/pkginf
	doins lib/ICAClient/pkginf/*
	insinto /opt/ICAClient/util
	doins lib/ICAClient/util/*
	exeinto /opt/ICAClient
	doexe lib/ICAClient/wfcmgr
	doexe lib/ICAClient/wfcmgr.bin
	doexe lib/ICAClient/wfica
	insinto /etc/env.d
	doins ${FILESDIR}/10ICAClient
}
