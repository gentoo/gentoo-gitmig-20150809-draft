# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_protection/mod_protection-0.0.2.ebuild,v 1.3 2003/07/13 21:44:10 aliz Exp $

inherit eutils

DESCRIPTION="Apache2 DSO providing basic IDS functions"
HOMEPAGE="http://www.twlc.net/"

NEWP="${PN}2-${PV}"
S=${WORKDIR}/${NEWP}
SRC_URI="mirror://gentoo/${NEWP}.tar.bz2"
DEPEND="=net-www/apache-2*"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A} || die; cd ${S} || die
	epatch ${FILESDIR}/mod_protection-0.0.2-register.patch
}

src_compile() {
	apxs2 -c ${PN}.c || die
}

src_install() {
	local i=26_mod_protection.conf
	local j=mod_protection.rules

	exeinto /usr/lib/apache2-extramodules
	doexe ${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/$i
	insopts -m 0644 -o root -g root
	doins $j

	dodoc ${FILESDIR}/$i $j COPYING Changes INSTALL README \
		THANX TODO USAGE
	docinto example-client; dodoc example-client/*
}
