# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/acid/acid-0.9.6_beta23.ebuild,v 1.11 2005/03/29 12:05:49 luckyduck Exp $

inherit webapp versionator eutils

MY_P=${P/_beta/b}
S=${WORKDIR}/${PN}
DESCRIPTION="Snort ACID - Analysis Console for Intrusion Databases"
HOMEPAGE="http://acidlab.sourceforge.net"
SRC_URI="http://acidlab.sourceforge.net/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="apache2"

# Note: jpgraph is an unstable package
RDEPEND="apache2? ( >=net-www/apache-2 )
	!apache2? ( =net-www/apache-1* )
	>=dev-php/adodb-4.0.5
	>=dev-php/jpgraph-1.12.2
	media-libs/gd
	=dev-php/mod_php-4*"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

pkg_setup() {
	webapp_pkg_setup

	built_with_use dev-php/mod_php gd || \
		die "dev-php/mod_php must be built with USE=gd"

	# If mod_php used is >= 5.0.0, it has to have session useflag enabled.
	local ver_modphp=$(best_version dev-php/mod_php)
	ver_modphp="${ver_modphp/dev-php\/mod_php-/}"
	if [[ $(get_major_version ${ver_modphp}) -ge 5 ]] ; then
		built_with_use dev-php/mod_php session || \
			die "dev-php/mod_php must be built with USE=session"
	fi
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

	einfo ""
	einfo "Note: ACID is installed as a webapp."
	einfo "The ACID database is an extension of the SNORT database."
	einfo "To setup the ACID database look in the README"
	einfo ""
}
