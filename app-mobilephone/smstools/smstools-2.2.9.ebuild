# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/smstools/smstools-2.2.9.ebuild,v 1.1 2006/10/20 13:14:15 chainsaw Exp $

inherit eutils

DESCRIPTION="Send and receive short messages through GSM modems"
HOMEPAGE="http://smstools.meinemullemaus.de/"
SRC_URI="http://www.meinemullemaus.de/software/${PN}/packages/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="stats"
RDEPEND="sys-process/procps
	 stats? ( >=dev-libs/mm-1.4.0 )"

S=${WORKDIR}/${PN}

pkg_setup() {
	enewgroup sms
	enewuser smsd -1 -1 /var/spool/sms sms
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/2.2.1-skip-dirlock.patch
	if use stats; then
		sed -i -e "s:CFLAGS += -D NOSTATS:#CFLAGS += -D NOSTATS:" src/Makefile
	fi
}

src_compile() {
	cd src
	emake || die "emake failed"
}

src_install() {
	dobin src/smsd
	cd ${S}/scripts
	dobin sendsms sms2html sms2unicode unicode2sms
	dobin hex2bin hex2dec email2sms
	dodoc mysmsd smsevent smsresend sms2xml sql_demo

	keepdir /var/spool/sms/incoming
	keepdir /var/spool/sms/outgoing
	keepdir /var/spool/sms/checked
	chown -R smsd:sms ${D}/var/spool/sms

	newinitd ${FILESDIR}/smsd.initd smsd
	insopts -o smsd -g sms -m0644
	insinto /etc
	newins ${S}/examples/smsd.conf.easy smsd.conf

	dohtml ${S}/doc/*
}

pkg_preinst() {
	pkg_setup
}

pkg_postinst() {
	chown -f smsd:sms /var/log/smsd.log
}
