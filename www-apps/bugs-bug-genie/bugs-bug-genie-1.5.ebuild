# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugs-bug-genie/bugs-bug-genie-1.5.ebuild,v 1.3 2004/09/02 13:40:02 dholm Exp $

inherit webapp
MY_PV=${PV/./_}
S=${WORKDIR}

IUSE=""

DESCRIPTION="BUGS - The Bug Genie"
HOMEPAGE="http://bugs-bug-genie.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/bugs_${MY_PV}.zip"

KEYWORDS="~x86 ~ppc"

RDEPEND="
	>=net-www/apache-1.3
	>=virtual/php-4.2.1
	>=dev-db/mysql-4
"

LICENSE="MPL-1.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix location of userbase_connect. see bug #50319
	sed -e "s|userbase_connect.inc.php|include/userbase_connect.inc.php|g" -i include/constants.inc.php
	# mysql_create_db is not there in MySQL 4
	sed -e "s|mysql_create_db(\"\$db_name\");|mysql_query\(\"create database \`\" . \$db_name . \"\`\"\);|
		s|\$dontDrawLeft = \"truly\";|\$dontDrawLeft = \"truly\";\n\$page = \"index\";|" -i install.php
	# userbase_connect.inc.php is missing
	echo '<?php if ($isInstall != "truly") trigger_error("Please use install.php to configure BUGS for your system!", E_USER_ERROR); ?>' > include/userbase_connect.inc.php
}

src_install() {
	webapp_src_preinst
	dodoc DISCLAIMER.TXT UPGRADE.TXT README.TXT changelog*
	cp -R LICENSE.TXT [[:lower:]][[:lower:]]* ${D}/${MY_HTDOCSDIR}
	rm -f ${D}/${MY_HTDOCSDIR}/changelog*
	webapp_serverowned ${MY_HTDOCSDIR}/include/userbase_connect.inc.php

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
