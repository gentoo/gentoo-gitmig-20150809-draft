# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icaclient/icaclient-6.30.ebuild,v 1.7 2003/09/05 22:01:48 msterret Exp $

S=${WORKDIR}/usr
DESCRIPTION="ICA Client"
SRC_URI="ICAClient-6.30-1.i386.rpm"
HOMEPAGE="http://www.citrix.com/download/unix-downloads.asp"
RDEPEND="virtual/glibc virtual/x11"
DEPEND="${RDEPEND} >=app-arch/rpm-3.0.6"
LICENSE="as-is"
SLOT="0"
RESTRICT="fetch"
KEYWORDS="x86 sparc "

dyn_fetch() {
	for y in ${A}
	do
		digest_check ${y}
			if [ $? -ne 0 ]; then
				einfo "Please download this yourself from www.citrix.com"
				einfo "and place it in ${DISTDIR}"
				exit 1
			fi
	done
}

src_unpack() {
	# You must download ICAClient-6.30-1.i386.rpm
	# from www.citrix.com and put it in ${DISTDIR}
	rpm2cpio ${DISTDIR}/${A} | cpio -i --make-directories
}

src_install () {
	dodir /opt/ICAClient
	insinto /opt/ICAClient/.config
	doins lib/ICAClient/.config/*
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
