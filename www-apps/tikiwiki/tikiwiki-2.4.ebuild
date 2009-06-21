# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/tikiwiki/tikiwiki-2.4.ebuild,v 1.2 2009/06/21 14:04:03 ranger Exp $

inherit webapp depend.php

DESCRIPTION="Full-featured Web Content Management System using PHP and Smarty Templates"
HOMEPAGE="http://tikiwiki.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
IUSE="mysql postgres graphviz"
KEYWORDS="~amd64 ppc ~sparc ~x86"

RDEPEND="graphviz? ( media-gfx/graphviz )"

need_httpd_cgi
need_php_httpd

pkg_setup () {
	webapp_pkg_setup

	local my_flags=
	use mysql && my_flags="${my_flags} mysql"
	use postgres && my_flags="${my_flags} postgres"

	require_php_with_use ${my_flags}
}

src_install() {
	webapp_src_preinst

	# Remove the execute permission from the setup.sh script
	# and rename it.  Its actions have been incorporated here.
	chmod a-x setup.sh
	mv setup.sh setup.sh.done

	dodoc changelog.txt copyright.txt doc/readme.txt doc/htaccess doc/htaccess.readme INSTALL README
	rm -rf changelog.txt copyright.txt doc/ INSTALL license.txt README

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	local DIR DIRENTRY
	local DIRS="backups db dump files img/trackers img/wiki
		img/wiki_up modules/cache temp
		templates_c templates styles maps whelp mods
		lib/Galaxia/processes"

	# Recursively set server ownership to allow server to write
	# This is the rough equivalent of the setup.sh script
	# provided in the distribution.
	# Note: Cannot use xargs or find -exec here because
	# these don't work with shell functions.

	webapp_serverowned "${MY_HTDOCSDIR}"
	webapp_serverowned "${MY_HTDOCSDIR}"/tiki-install.php

	# ensure that directories exist, some don't.
	# (part of original setup.sh)
	for DIR in ${DIRS}; do
		dodir "${MY_HTDOCSDIR}/${DIR}"
		webapp_serverowned -R "${MY_HTDOCSDIR}/${DIR}"
	done

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
