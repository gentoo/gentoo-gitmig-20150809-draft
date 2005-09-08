# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/acid/acid-0.9.6_beta23.ebuild,v 1.13 2005/09/08 23:16:04 vanquirius Exp $

inherit webapp versionator eutils depend.php

MY_P=${P/_beta/b}
S=${WORKDIR}/${PN}
DESCRIPTION="Snort ACID - Analysis Console for Intrusion Databases"
HOMEPAGE="http://acidlab.sourceforge.net"
SRC_URI="http://acidlab.sourceforge.net/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="apache2"

# TODO: check for php-5 support
RDEPEND="apache2? ( >=net-www/apache-2 )
	!apache2? ( =net-www/apache-1* )
	>=dev-php/adodb-4.0.5
	>=dev-php/jpgraph-1.12.2
	media-libs/gd
	=virtual/httpd-php-4*"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

pkg_setup() {
	webapp_pkg_setup

	need_php4
	require_php_with_use gd session
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i '12s:^$DBlib_path =.*:$DBlib_path = "/usr/lib/php/adodb";:' \
		acid_conf.php || die "sed acid_conf.php failed"
	sed -i '67s/($version\[0\] >= 4)/($version[0] >= 5) || &/' \
		acid_db_common.php || die "sed acid_db_common.php failed"
}

src_install () {
	webapp_src_preinst

	insinto ${MY_HTDOCSDIR}
	doins *

	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst

	einfo "Note: ACID is installed as a webapp."
	einfo "The ACID database is an extension of the SNORT database."
	einfo "To setup the ACID database look in the README"
}
