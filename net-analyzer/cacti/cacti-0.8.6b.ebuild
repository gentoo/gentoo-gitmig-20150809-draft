# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.8.6b.ebuild,v 1.4 2004/11/07 20:13:13 weeve Exp $

inherit eutils webapp

DESCRIPTION="Cacti is a complete frontend to rrdtool"
HOMEPAGE="http://www.cacti.net/"
SRC_URI="http://www.cacti.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha ~amd64"
IUSE="snmp"

DEPEND=""

# TODO: RDEPEND Not just apache... but there's no virtual/webserver (yet)

RDEPEND="net-www/apache
	snmp? ( virtual/snmp )
	net-analyzer/rrdtool
	dev-db/mysql
	virtual/cron
	dev-php/php
	dev-php/mod_php"

check_useflag() {
	local my_pkg=$(best_version ${1})
	local my_flag=${2}

	if [[ $(grep -wo ${my_flag} /var/db/pkg/${my_pkg}/USE) ]]
	then
		return 0
	fi

	eerror "${my_pkg} was compiled without ${my_flag}. Please re-emerge it with USE=${my_flag}"
	die "check_useflag failed"

}

pkg_setup() {
	webapp_pkg_setup

	# Check if php, mod_php was emerged with mysql useflag

	check_useflag dev-php/php mysql
	check_useflag dev-php/mod_php mysql
}

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	webapp_src_preinst

	dodoc LICENSE
	rm LICENSE README

	dodoc docs/{CHANGELOG,CONTRIB,INSTALL,README,REQUIREMENTS,UPGRADE}
	rm -rf docs
	#Don't overwrite old config
	mv include/config.php include/config-sample.php

	edos2unix `find -type f -name '*.php'`

	dodir ${D}${MY_HTDOCSDIR}
	cp -r . ${D}${MY_HTDOCSDIR}

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

