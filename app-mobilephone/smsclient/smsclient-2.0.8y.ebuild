# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/smsclient/smsclient-2.0.8y.ebuild,v 1.1 2005/10/18 22:28:04 r3pek Exp $

inherit eutils

# Weird name scheme ...
MY_PV=${PVR/y/}
MY_P=${P/sms/sms_}

DESCRIPTION="Utility to send sms messages to phones and pagers."
HOMEPAGE="http://www.smsclient.org"
SRC_URI="http://www.smsclient.org/download/${PN}-${MY_PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	./configure || die "Configure failed"
	sed -i -e "s/-g -I. -Wall/${CFLAGS} -I./g" Makefile.config || \
		die "sed failed"
	make || die "Make failed"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}_sms-makefile.patch
	epatch ${FILESDIR}/${P}_client-makefile.patch
	epatch ${FILESDIR}/${P}_logfile-makefile.patch
	epatch ${FILESDIR}/${P}_docs-makefile.patch
}


src_install() {
	make DESTDIR=${D} install || die "Install failed"
	dodir /usr/bin
	dosym /bin/sms_client /usr/bin/smsclient
	dosym /bin/sms_address /usr/bin/smsaddress
}
