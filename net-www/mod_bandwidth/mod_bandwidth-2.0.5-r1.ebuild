# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_bandwidth/mod_bandwidth-2.0.5-r1.ebuild,v 1.1 2005/01/08 21:06:39 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Bandwidth Management Module for Apache"
HOMEPAGE="http://www.cohprog.com/v3/bandwidth/intro-en.html"
SRC_URI="ftp://ftp.cohprog.com/pub/apache/module/1.3.0/mod_bandwidth.c"

KEYWORDS="~x86 ~sparc ~ppc"
DEPEND=""
LICENSE="Apache-1.1"
SLOT="0"
IUSE=""

APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="BANDWIDTH"

need_apache1

src_unpack() {
	mkdir -p ${S} && cp ${DISTDIR}/${A} ${S} || die
	cd ${S} || die
	epatch ${FILESDIR}/${P}-register.patch || die
	sed -i -e "s:define MOD_BANDWIDTH_VERSION_S.*:define MOD_BANDWIDTH_VERSION_S \"${PV}\":" mod_bandwidth.c || die "version fix failed"
}

pkg_postinst() {
	# empty dirs
	install -m0755 -o apache -g apache -d ${ROOT}/var/cache/mod_bandwidth/{link,master}
	apache1_pkg_postinst
}
