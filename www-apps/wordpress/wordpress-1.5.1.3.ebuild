# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/wordpress/wordpress-1.5.1.3.ebuild,v 1.1 2005/06/30 03:00:09 superlag Exp $

inherit webapp eutils

#Wordpress releases have a release name tagged on the end of the version on the tar.gz files
#wordpress 1.2.1 has no extension
#MY_EXT="mingus"

DESCRIPTION="Wordpress php and mysql based CMS system."
HOMEPAGE="http://wordpress.org/"
#Latest version is only available in the format!
#Download is renamed by HTTP Header as wordpress-1.5.1.2.tar.gz
SRC_URI=mirror://gentoo/${P}.tar.gz
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=">=dev-php/mod_php-4.1
	 >=dev-db/mysql-3.23.23"

DEPEND="${DEPEND} ${RDEPEND} >=net-www/webapp-config-1.10-r5"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
# no patch needed anymore
#	epatch ${FILESDIR}/${PV}/login-patch.diff
}

src_install() {
	local docs="license.txt readme.html"

	webapp_src_preinst

	# remove wp-admin/templates.php (XSS exploit).  See bug #88926.
	rm -f wp-admin/templates.php
	cp ${FILESDIR}/dummy-templates.php wp-admin/templates.php

	einfo "Installing main files"
	cp -r * ${D}${MY_HTDOCSDIR}
	einfo "Done"

	# handle documentation files
	#
	# NOTE that doc files go into /usr/share/doc as normal; they do NOT
	# get installed per vhost!

	dodoc ${docs}
	for doc in ${docs} INSTALL; do
		rm -f ${doc}
	done

	# Identify the configuration files that this app uses
	# User can want to make changes to these!
	webapp_serverowned ${MY_HTDOCSDIR}/index.php
	#webapp_serverowned ${MY_HTDOCSDIR}/wp-layout.css
	webapp_serverowned ${MY_HTDOCSDIR}/wp-admin/menu.php
	webapp_serverowned ${MY_HTDOCSDIR}

	# Identify any script files that need #! headers adding to run under
	# a CGI script (such as PHP/CGI)
	#
	# for wordpress, we *assume* that all .php files need to have CGI/BIN
	# support added

	for x in `find . -name '*.php' -print ` ; do
		webapp_runbycgibin php ${MY_HTDOCSDIR}/$x
	done

	# post-install instructions
	#webapp_postinst_txt en ${FILESDIR}/1.2/postinstall-en.txt

	# now strut stuff
	webapp_src_install

}
