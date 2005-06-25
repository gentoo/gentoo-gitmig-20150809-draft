# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/dragonflycms/dragonflycms-9.0.3.0.ebuild,v 1.3 2005/06/25 16:58:58 sejo Exp $

inherit webapp

MY_P=Dragonfly${PV}
DESCRIPTION="CPG Dragonfly CMS is a feature-rich open source content management
system based off of PHP-Nuke 6.5"
HOMEPAGE="http://dragonflycms.org"
SRC_URI="mirror://gentoo/$MY_P.tar.bz2
http://dev.gentoo.org/~sejo/files/Dragonfly9.0.3.0.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=dev-db/mysql-3.23.32 <dev-db/mysql-5.1
	 virtual/httpd-php"
RDEPEND=""

src_unpack() {
	unpack ${A}
}

src_install() {

	webapp_src_preinst

	#Do the documentation
	insinto /usr/share/doc/${PF}
	doins -r ${WORKDIR}/documentation/*

	#installing files where they need to be.
	einfo "installing php main files"
	cp -r ${WORKDIR}/public_html/* ${D}${MY_HTDOCSDIR}
	einfo "Done"

	#identiy the configuration file the app uses

	webapp_configfile ${MY_HTDOCSDIR}/config.php

	# add the postinstall instructions

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	# done, now strut the stuff

	webapp_src_install

}
