# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_backhand/mod_backhand-1.2.2.ebuild,v 1.2 2005/02/25 15:03:59 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Apache module for load balancing and web clustering"
HOMEPAGE="http://www.backhand.org/mod_backhand/"
SRC_URI="mirror://gentoo/${PN}-${PV}.tar.gz"

KEYWORDS="~x86"
DEPEND=""
LICENSE="as-is"
SLOT="0"
IUSE=""

DOCFILES="ChangeLog INSTALL LICENSE NOTES NOTICE README.bySession TODO"

APACHE1_MOD_CONF="05_${PN}"
APACHE1_MOD_DEFINE="BACKHAND"

APXS1_ARGS="-c -o ${PN}.so apue.c arriba.c back_util.c builtins.c ${PN}.c"

need_apache1

src_compile() {
	econf
	apache-module_src_compile
	${APXS1} -c -o byHostname.so byHostname.c || die "apxs failed"
}

pkg_postinst() {
	install -d -m 0755 -o apache -g apache ${ROOT}/var/lib/backhand
	apache-module_pkg_postinst
}
