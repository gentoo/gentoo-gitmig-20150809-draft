# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phprojekt/phprojekt-4.2.3.ebuild,v 1.5 2007/01/03 19:03:17 rl03 Exp $

inherit webapp eutils

DESCRIPTION="Project management and coordination system"
HOMEPAGE="http://www.phprojekt.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://phprojekt.com/files/4.2/setup.zip
	http://phprojekt.com/files/4.2/lib.zip"

LICENSE="GPL-2"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="net-www/apache
		virtual/php"
DEPEND="app-arch/unzip"

src_unpack () {
	unpack ${A}
	# security bug 89950
	epatch ${FILESDIR}/${P}-fix-chat-vuln.diff
}

pkg_setup () {
	webapp_pkg_setup
	elog "Please make sure that your PHP is compiled with support for IMAP and your database of choice"
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
