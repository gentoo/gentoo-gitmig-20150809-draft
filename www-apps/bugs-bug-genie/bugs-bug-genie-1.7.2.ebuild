# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugs-bug-genie/bugs-bug-genie-1.7.2.ebuild,v 1.3 2007/01/02 22:17:23 rl03 Exp $

inherit webapp
S=${WORKDIR}/bugs_${PV}

IUSE=""

DESCRIPTION="BUGS - The Bug Genie"
HOMEPAGE="http://bugs-bug-genie.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/BUGS_${PV}.zip"

KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="app-arch/unzip"
RDEPEND=">=net-www/apache-1.3
		virtual/php"

LICENSE="MPL-1.1"

src_install() {
	webapp_src_preinst
	dodoc DISCLAIMER.TXT UPGRADE.TXT README.TXT doc/changelog*

	cp -R LICENSE.TXT [[:lower:]][[:lower:]]* ${D}/${MY_HTDOCSDIR}

	local files="include/userbase_connect.inc.php files include lang smileys
		themes"
	for a in files; do
		webapp_serverowned ${MY_HTDOCSDIR}/${a}
	done
	webapp_serverowned ${MY_HTDOCSDIR}

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
