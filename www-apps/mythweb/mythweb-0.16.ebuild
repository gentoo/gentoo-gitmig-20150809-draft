# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-0.16.ebuild,v 1.2 2004/09/10 23:27:13 aliz Exp $

inherit webapp

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=dev-php/mod_php-4.2"

pkg_setup() {
	if has_version \>=dev-php/mod_php-5 ; then
		local modphp_use="$(</var/db/pkg/`best_version =dev-php/mod_php`/USE)"
	        if ! has session ${modphp_use} ; then
	                eerror "mod_php is missing session support. Please add"
	                eerror "'session' to your USE flags, and re-emerge mod_php and php."
	                die "mod_php needs session support"
	        fi
	fi

	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	dodoc README TODO

	cp -R [[:lower:]]* ${D}/${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/config/conf.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
