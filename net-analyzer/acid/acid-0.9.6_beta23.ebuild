# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/acid/acid-0.9.6_beta23.ebuild,v 1.5 2004/10/11 23:10:52 eldad Exp $

inherit webapp

MY_P=${P/_beta/b}
DESCRIPTION="Snort ACID - Analysis Console for Intrusion Databases"
HOMEPAGE="http://acidlab.sourceforge.net"
SRC_URI="http://acidlab.sourceforge.net/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"

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

pkg_setup() {
	# Check if mod_php was emerged with GD
	my_modphp=$(best_version dev-php/mod_php)

	if [[ ! $(grep -wo gd /var/db/pkg/${my_modphp}/USE) ]];
	then
		eerror "${my_modphp} was compiled without gd support. Please reemerge it with USE=gd."
		die "pkg_setup failed"
	fi
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
