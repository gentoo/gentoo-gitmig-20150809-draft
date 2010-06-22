# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/websvn/websvn-2.2.1.ebuild,v 1.6 2010/06/22 18:55:54 arfrever Exp $

inherit depend.php eutils webapp

MY_PV="${PV//_/}"
MY_P="${P//_/}"

DESCRIPTION="Web-based browsing tool for Subversion (SVN) repositories in PHP"
HOMEPAGE="http://websvn.tigris.org/"
SRC_URI="http://websvn.tigris.org/files/documents/1380/45918/${MY_P}.tar.gz"

RESTRICT="mirror"
LICENSE="GPL-2"
IUSE="enscript"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"

RDEPEND="dev-vcs/subversion
	enscript? ( app-text/enscript )"

need_httpd_cgi
need_php_httpd

S="${WORKDIR}"/${MY_P}

pkg_setup() {
	webapp_pkg_setup
	has_php
	require_php_with_use xml
}

src_install() {
	webapp_src_preinst

	mv include/{dist,}config.php

	dodoc changes.txt || die "dodoc failed"
	dohtml doc/* || die "dohtml failed"
	rm -rf license.txt changes.txt doc/

	insinto "${MY_HTDOCSDIR}"
	doins -r . || die "doins failed"

	webapp_configfile "${MY_HTDOCSDIR}"/include/config.php
	webapp_configfile "${MY_HTDOCSDIR}"/wsvn.php

	webapp_serverowned "${MY_HTDOCSDIR}"/cache

	webapp_src_install
}
