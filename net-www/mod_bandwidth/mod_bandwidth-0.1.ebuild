# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_bandwidth/mod_bandwidth-0.1.ebuild,v 1.1 2005/01/08 21:06:39 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Bandwidth Management Module for Apache 2.0"
HOMEPAGE="http://www.ivn.cl/apache/"
SRC_URI="http://www.ivn.cl/apache/mod_bandwidth-0.1.tgz"

KEYWORDS="~x86"
DEPEND=""
LICENSE="Apache-1.1"
SLOT="1"
IUSE=""

APXS2_ARGS="-c ${PN}.c"
APACHE2_MOD_CONF="11_${PN}"
APACHE2_MOD_DEFINE="BANDWIDTH"

need_apache2

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/mod_bandwidth-0.1-register.patch || die
	mv ${S}/{mod_bandwidth-0.1.c,mod_bandwidth.c}
}

pkg_postinst() {
	# empty dirs
	install -m0755 -o apache -g apache -d ${ROOT}/var/cache/mod_bandwidth/{link,master}
	apache2_pkg_postinst
}
