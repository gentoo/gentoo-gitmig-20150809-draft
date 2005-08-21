# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugs-bug-genie/bugs-bug-genie-1.7.1.ebuild,v 1.2 2005/08/21 16:51:17 rl03 Exp $

inherit webapp
S=${WORKDIR}/BUGS_${PV}

IUSE=""

DESCRIPTION="BUGS - The Bug Genie"
HOMEPAGE="http://bugs-bug-genie.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/BUGS_${PV}.zip"

KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="app-arch/unzip"
RDEPEND=">=net-www/apache-1.3
		virtual/php
		>=dev-db/mysql-4"

LICENSE="MPL-1.1"

src_install() {
	webapp_src_preinst
	dodoc DISCLAIMER.TXT UPGRADE.TXT README.TXT doc/changelog*
	dohtml doc/*.htm

	cp -R LICENSE.TXT [[:lower:]][[:lower:]]* ${D}/${MY_HTDOCSDIR}
	rm -rf ${D}/${MY_HTDOCSDIR}/doc

	local file
	for file in files include lang smileys themes; do
		webapp_serverowned ${MY_HTDOCSDIR}/${file}
	done
	webapp_serverowned ${MY_HTDOCSDIR}

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
