# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/tikiwiki/tikiwiki-1.8.5-r2.ebuild,v 1.2 2005/08/22 20:18:42 hansmi Exp $

inherit eutils webapp

DESCRIPTION="Full featured Web Content Management System using Php and Smarty Templates"
HOMEPAGE="http://tikiwiki.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
IUSE=""
KEYWORDS="~amd64 ppc ~sparc ~x86"

RDEPEND="virtual/php
	media-gfx/graphviz"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/xmlrpc2-${PV}.patch
}

src_install() {
	webapp_src_preinst

	local DIR
	local DIRENTRY
	local DIRS="backups db dump img/wiki
		img/wiki_up modules/cache temp temp/cache
		templates_c templates styles lib/Galaxia/processes"


	# Ensure that directories exist, some don't.
	# (part of setup.sh)
	#
	for DIR in ${DIRS}; do
		mkdir -p ${DIR}
	done

	# Remove the execute permission from the setup.sh script
	# and rename it.  Its actions have been incorporated here.
	#
	chmod a-x setup.sh
	mv setup.sh setup.sh.done

	# Install the minimal doc (points to web page)
	#
	dodoc doc/readme.txt doc/htaccess doc/htaccess.readme INSTALL README

	# The bulk goes into htdocs
	# but don't copy INSTALL and README
	cp -a [[:lower:]]* ${D}/${MY_HTDOCSDIR}

	# Recursively set server ownership to allow server to write
	# This is the rough equivalent of the setup.sh script
	# provided in the distribution.
	# Note: Cannot use xargs or find -exec here because 
	# 		these don't	work with shell functions.
	#
	webapp_serverowned ${MY_HTDOCSDIR}
	for DIR in ${DIRS}; do
		find ${DIR} | while read DIRENTRY; do
			webapp_serverowned ${MY_HTDOCSDIR}/${DIRENTRY}
		done
	done

	# Flag files for scripting engine
	#
	find . -name '*.php' -a ! -name '*.inc.php' | while read DIRENTRY; do
		webapp_runbycgibin php ${MY_HTDOCSDIR}/${DIRENTRY}
	done

	# Setup some post-install notes for webapp-config
	#
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

pkg_config() {
	einfo "Type in your MySQL root password to create an empty tiki database:"
	mysqladmin -u root -p create tikiwiki
	einfo
	einfo
	einfo "Now, point your browser to the location of tiki-install.php"
	einfo "    ==> e.g. http://localhost/tikiwiki/tiki-install.php"
	einfo
}
