# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/acid/acid-0.9.6_beta23.ebuild,v 1.7 2004/10/25 17:48:46 hansmi Exp $

inherit webapp

MY_P=${P/_beta/b}
DESCRIPTION="Snort ACID - Analysis Console for Intrusion Databases"
HOMEPAGE="http://acidlab.sourceforge.net"
SRC_URI="http://acidlab.sourceforge.net/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE="apache2"
S=${WORKDIR}/${PN}

# Note: jpgraph is an unstable package
DEPEND="apache2? ( >=net-www/apache-2 )
	!apache2? ( =net-www/apache-1* )
	>=dev-php/adodb-4.0.5
	>=dev-php/jpgraph-1.12.2
	media-libs/gd
	dev-php/mod_php
	net-analyzer/snort"

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

	check_useflag dev-php/mod_php gd
}

src_compile () {
	einfo "Nothing to compile."
}

src_install () {
	webapp_src_preinst

	sed -i -e '12s:^$DBlib_path =.*:$DBlib_path = "/usr/lib/php/adodb";:' acid_conf.php

	insinto ${MY_HTDOCSDIR}
	doins *

	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst

	einfo ""
	einfo "Note: ACID is installed as a webapp."
	einfo "The ACID database is an extension of the SNORT database."
	einfo "To setup the ACID database look in the README"
	einfo ""
}
