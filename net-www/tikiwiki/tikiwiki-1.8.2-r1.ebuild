# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/tikiwiki/tikiwiki-1.8.2-r1.ebuild,v 1.2 2004/08/05 07:08:02 mholzer Exp $

inherit webapp

DESCRIPTION="Full featured Web Content Management System using Php and Smarty Templates"
HOMEPAGE="http://tikiwiki.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
IUSE=""
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND="virtual/php
	media-gfx/graphviz"

src_install() {
	webapp_src_preinst

	local DIR
	local DIRENTRY
	local DIRS="backups db dump img/wiki
		img/wiki_up modules/cache temp temp/cache
		templates_c var var/log var/log/irc templates
		styles lib/Galaxia/processes"


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
	dodoc doc/readme.txt
	dodoc doc/htaccess
	dodoc doc/htaccess.readme
	dodoc INSTALL
	dodoc README
	rm INSTALL README

	# The bulk goes into htdocs
	#
	cp -a . ${D}/${MY_HTDOCSDIR}

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


