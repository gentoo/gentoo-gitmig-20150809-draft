# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phppgadmin/phppgadmin-3.5.ebuild,v 1.1 2004/11/16 23:01:22 matsuu Exp $

inherit eutils webapp

IUSE=""

# This package insists on uppercase letters
MY_PN=phpPgAdmin
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="Web-based administration for Postgres database in php"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://phppgadmin.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64"

DEPEND=">=dev-db/postgresql-7.0.0
	>=dev-php/mod_php-4.1"

RDEPEND="${DEPEND}
	!<=dev-db/phppgadmin-3.3.1"

src_compile() {
	mv libraries/lib.inc.php ${T}/lib.inc.php
	mv login.php ${T}/login.php
	sed -e "s|conf/config.inc.php|/etc/phppgadmin/config.inc.php|g" \
		${T}/login.php > login.php
	sed -e "s|include('./conf|include('conf|g" \
		-e "s|conf/config.inc.php|/etc/phppgadmin/config.inc.php|g" \
		${T}/lib.inc.php > libraries/lib.inc.php
}

src_install() {
	webapp_src_preinst

	local docs="DEVELOPERS FAQ HISTORY INSTALL TODO TRANSLATORS CREDITS LICENSE BUGS"

	dodoc ${docs}
	for docs in ${docs} INSTALL; do
		rm -f $doc
	done

	dodir /etc/phppgadmin
	mv conf/* sql/* ${D}/etc/phppgadmin/
	rm -fr config/ sql/

	cp -r * ${D}${MY_HTDOCSDIR}

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
