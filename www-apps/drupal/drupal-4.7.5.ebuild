# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drupal/drupal-4.7.5.ebuild,v 1.1 2007/01/06 09:01:38 uberlord Exp $

inherit webapp eutils

MY_PV=${PV:0:3}.0

DESCRIPTION="PHP-based open-source platform and content management system"
HOMEPAGE="http://drupal.org/"
SRC_URI="http://drupal.org/files/projects/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/httpd-php"

src_install() {
	webapp_src_preinst

	local docs="MAINTAINERS.txt LICENSE.txt INSTALL.txt CHANGELOG.txt"
	dodoc ${docs}
	rm -f ${docs} INSTALL

	einfo "Copying main files"
	cp -r . "${D}/${MY_HTDOCSDIR}"

	# we install the .htaccess file to enable support for clean URLs
	cp .htaccess "${D}/${MY_HTDOCSDIR}"

	# create the files upload directory
	mkdir "${D}/${MY_HTDOCSDIR}"/files
	webapp_serverowned "${MY_HTDOCSDIR}"/files

	webapp_configfile "${MY_HTDOCSDIR}"/sites/default/settings.php
	webapp_src_install
}

