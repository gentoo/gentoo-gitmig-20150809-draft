# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/dokuwiki/dokuwiki-20101107.ebuild,v 1.1 2010/11/09 22:17:08 ramereth Exp $

inherit webapp depend.php

# upstream uses dashes in the datestamp
MY_BASE_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"
MY_PV="${MY_BASE_PV}${PV:8:1}"

DESCRIPTION="DokuWiki is a simple to use Wiki aimed at a small company's documentation needs."
HOMEPAGE="http://wiki.splitbrain.org/wiki:dokuwiki"
SRC_URI="http://www.splitbrain.org/_media/projects/${PN}/${PN}-${MY_PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

need_httpd_cgi
need_php_httpd

S="${WORKDIR}/${PN}-${MY_BASE_PV}"

pkg_setup() {
	webapp_pkg_setup
	has_php
	if [[ ${PHP_VERSION} == "4" ]] ; then
		require_php_with_use cli expat
	else
		require_php_with_use cli xml
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# create initial changes file
	touch data/changes.log
}

src_install() {
	webapp_src_preinst

	dodoc README
	rm -f README COPYING VERSION

	docinto scripts
	dodoc bin/*
	rm -rf bin

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	for x in $(find data/ -not -name '.htaccess'); do
		webapp_serverowned "${MY_HTDOCSDIR}"/${x}
	done

	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess.dist
	webapp_configfile "${MY_HTDOCSDIR}"/conf

	for x in $(find conf/ -not -name 'msg'); do
		webapp_configfile "${MY_HTDOCSDIR}"/${x}
	done

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
