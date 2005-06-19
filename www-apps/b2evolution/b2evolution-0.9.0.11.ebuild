# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/b2evolution/b2evolution-0.9.0.11.ebuild,v 1.2 2005/06/19 21:03:25 dostrow Exp $

inherit webapp eutils

MY_EXT="d-2004-09-22"

DESCRIPTION="Multilingual multiuser multi-blog engine"
HOMEPAGE="http://www.b2evolution.net"
SRC_URI="mirror://sourceforge/evocms/${P}${MY_EXT}.zip"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND=">=dev-php/mod_php-4.1
	 >=dev-db/mysql-3.23.23"

DEPEND="${DEPEND} ${RDEPEND}
	>=net-www/webapp-config-1.10-r5
	app-arch/unzip"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# http://secunia.com/advisories/13718/
	sed -i "s:post_urltitle = '\$title'\";:post_urltitle = \".\$DB->quote(\$title);:" \
		blogs/b2evocore/_class_itemlist.php
}

src_install() {
	webapp_src_preinst

	einfo "Installing main files"
	cp -r blogs/* ${D}${MY_HTDOCSDIR}
	einfo "Done"

	dodoc doc/license.txt doc/install_new.html doc/upgradefrom_b2evo.html doc/upgradefrom_b2.html \
		doc/upgradefrom_gl.html doc/upgradefrom_miniblog.html doc/upgradefrom_mt.html

	# Identify the configuration files that this app uses
	# User can want to make changes to these!
	webapp_serverowned ${MY_HTDOCSDIR}/conf/_config.php
	webapp_serverowned ${MY_HTDOCSDIR}

	# post-install instructions
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	# now strut stuff
	webapp_src_install
}
