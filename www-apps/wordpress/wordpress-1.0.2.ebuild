# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/wordpress/wordpress-1.0.2.ebuild,v 1.2 2004/09/03 17:17:21 pvdabeel Exp $
# Mostly ripped off from the squirrelmail ebuild!
# By Peter Westwood <peter.westwood@ftwr.co.uk>

inherit webapp eutils

#Wordpress releases have a release name tagged on the end of the version on the tar.gz files
MY_EXT="blakey"

DESCRIPTION="Wordpress php and mysql based CMS system."
HOMEPAGE="http://wordpress.org/"
SRC_URI="mirror://sourceforge/cafelog/${P}-${MY_EXT}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc"
IUSE=""
RDEPEND=">=dev-php/mod_php-4.1
	 >=dev-db/mysql-3.23.23"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack "${A}"
	cd ${S}
	epatch ${FILESDIR}/${P}.gentoo.diff
}

src_compile() {
	#Do we need to do any random passwd setup?

	#we need to have this empty function ... default compile hangs
	echo "Nothing to compile"
}

src_install() {
	local docs="license.txt readme.html"

	webapp_src_preinst

	einfo "Installing main files"
	echo ${D}
	cp -r . ${D}${MY_HTDOCSDIR}

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
	webapp_serverowned ${MY_HTDOCSDIR}/wp-layout.css
	webapp_serverowned ${MY_HTDOCSDIR}/wp-admin/menu.txt
	webapp_serverowned ${MY_HTDOCSDIR}

	# Identify any script files that need #! headers adding to run under
	# a CGI script (such as PHP/CGI)
	#
	# for wordpress, we *assume* that all .php files need to have CGI/BIN
	# support added

	for x in `find . -name '*.php' -print ` ; do
		webapp_runbycgibin php ${MY_HTDOCSDIR}/$x
	done

	# now strut stuff
	webapp_src_install
}
