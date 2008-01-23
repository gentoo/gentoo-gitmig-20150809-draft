# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/joomla/joomla-1.5.0.ebuild,v 1.1 2008/01/23 09:29:55 wrobel Exp $

inherit webapp depend.php

MY_PN=${PN/j/J}

DESCRIPTION="Joomla is one of the most powerful Open Source Content Management Systems on the planet."
HOMEPAGE="http://www.joomla.org/"
SRC_URI="http://joomlacode.org/gf/download/frsrelease/5078/21063/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
S="${WORKDIR}"

IUSE=""

RDEPEND="virtual/httpd-cgi"

need_php

pkg_setup () {
	webapp_pkg_setup
	require_php_with_use mysql zlib
}

src_install () {
	webapp_src_preinst
	local files="administrator/backups administrator/components
	administrator/modules administrator/templates cache components
	images images/banners images/stories language
	media modules templates configuration.php"

	dodoc CHANGELOG.php INSTALL.php

	cp -R . "${D}/${MY_HTDOCSDIR}"

	# Create an empty configuration file that will be writeable
	#to the web server
	touch "${D}/${MY_HTDOCSDIR}/configuration.php"

	for file in ${files}; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_configfile "${MY_HTDOCSDIR}/configuration.php"

	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"

	webapp_src_install
}
