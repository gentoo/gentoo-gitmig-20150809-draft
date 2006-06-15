# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/smstools/smstools-2.2.1-r1.ebuild,v 1.1 2006/06/15 09:56:00 chainsaw Exp $

inherit eutils

DESCRIPTION="Send and receive short messages through GSM modems"
HOMEPAGE="http://smstools.meinemullemaus.de/"
SRC_URI="http://www.meinemullemaus.de/software/${PN}/packages/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-skip-dirlock.patch
}

src_compile() {
	cd src
	emake || die "emake failed"
}

src_install() {
	dobin src/smsd
	dobin scripts/sendsms scripts/sms2html
	dobin scripts/sms2unicode scripts/unicode2sms

	keepdir /var/spool/sms/incoming
	keepdir /var/spool/sms/outgoing
	keepdir /var/spool/sms/checked

	newinitd ${FILESDIR}/smsd.initd smsd
	insinto /etc
	newins examples/smsd.conf.easy smsd.conf
}
