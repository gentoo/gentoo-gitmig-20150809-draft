# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phprojekt/phprojekt-4.2.3.ebuild,v 1.2 2005/05/30 07:13:40 hansmi Exp $

inherit webapp eutils

DESCRIPTION="Project management and coordination system"
HOMEPAGE="http://www.phprojekt.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://phprojekt.com/files/4.2/setup.zip
	http://phprojekt.com/files/4.2/lib.zip"

LICENSE="GPL-2"
KEYWORDS="ppc x86"
IUSE="postgres mysql"

RDEPEND="net-www/apache
		postgres? ( dev-db/postgresql )
		mysql? ( dev-db/mysql )
		virtual/php"
DEPEND="app-arch/unzip"

src_unpack () {
	unpack ${A}
	# security bug 89950
	epatch ${FILESDIR}/${P}-fix-chat-vuln.diff
}

pkg_setup () {
	webapp_pkg_setup
	einfo "Please make sure that your PHP is compiled with support for IMAP and your database of choice"
}

src_install() {
	webapp_src_preinst

	dodoc ChangeLog install readme
	rm -f ChangeLog install readme
	cp -R . ${D}/${MY_HTDOCSDIR}
	for file in chat attach upload; do
		webapp_serverowned ${MY_HTDOCSDIR}/${file}
	done
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
