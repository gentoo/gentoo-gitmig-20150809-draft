# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/cistronradius/cistronradius-1.6.7.ebuild,v 1.6 2005/04/14 20:45:25 mrness Exp $

IUSE=""

S="${WORKDIR}/radiusd-cistron-${PV}/src"
DESCRIPTION="An authentication and accounting server for terminal servers that speak the RADIUS protocol."
SRC_URI="ftp://ftp.radius.cistron.nl/pub/radius/radiusd-cistron-${PV}.tar.gz"
HOMEPAGE="http://www.radius.cistron.nl/"
KEYWORDS="x86 -*"
LICENSE="GPL-2"
SLOT="0"

DEPEND="!net-dialup/freeradius
	!net-dialup/gnuradius
	virtual/libc
	>=sys-apps/sed-4*"

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i -e "s:/usr/local:/usr:g" \
	-e "s:-Wall -g:${CFLAGS}:g" \
	Makefile || die
	mv checkrad.pl checkrad
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/sbin
	exeinto /usr/sbin
	doexe ${S}/checkrad
	doexe ${S}/radiusd
	doexe ${S}/radrelay
	dodir /usr/bin
	exeinto /usr/bin
	doexe ${S}/radclient
	doexe ${S}/radlast
	doexe ${S}/radtest
	doexe ${S}/raduse
	doexe ${S}/radwho
	doexe ${S}/radzap
	exeinto /etc/init.d
	newexe ${FILESDIR}/cistronradius.rc cistronradius
	cd ${S}/..
	dodir /etc/raddb
	insinto /etc/raddb
	doins raddb/*
	dodoc COPYRIGHT INSTALL README doc/{ChangeLog,FAQ.txt,README*}
	doman doc/{*.1,*.8,*.5rad,*.8rad}
}
