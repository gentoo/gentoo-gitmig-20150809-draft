# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gnopaste/gnopaste-0.5.5.ebuild,v 1.1 2007/04/24 10:34:19 jurek Exp $

inherit webapp

DESCRIPTION="It presents a free nopaste system like http://nopaste.info"
HOMEPAGE="http://gnopaste.sf.net/"
LICENSE="GPL-2"

SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"

KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/mysql
	net-www/apache
	dev-lang/php"

src_install() {
	# call the eclass, to initialise the image directory for us
	webapp_src_preinst

	# copy the app's main files
	elog "Installing main files"
	cp -r . "${D}/${MY_HTDOCSDIR}"

	# identify the configuration files that this app uses
	webapp_configfile "${MY_HTDOCSDIR}/config.php"

	# identify any files and directories that need to be owned
	# by the user that the server runs under
	webapp_serverowned "${MY_HTDOCSDIR}/config.php"
	webapp_serverowned "${MY_HTDOCSDIR}/install.php"

	# add the post-installation instructions
	webapp_postinst_txt en "${FILESDIR}/postinstall-en-${PV}.txt"

	# all done
	webapp_src_install
}
