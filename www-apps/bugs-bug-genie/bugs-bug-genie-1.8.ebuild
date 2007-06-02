# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugs-bug-genie/bugs-bug-genie-1.8.ebuild,v 1.1 2007/06/02 05:28:44 rl03 Exp $

inherit webapp depend.php

S=${WORKDIR}/BUGS_${PV}_RELEASE

IUSE=""

DESCRIPTION="BUGS - The Bug Genie"
HOMEPAGE="http://www.thebuggenie.com/"
SRC_URI="mirror://sourceforge/${PN}/BUGS_${PV}.zip"

KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="app-arch/unzip"

LICENSE="MPL-1.1"

need_php

src_install() {
	webapp_src_preinst
	dodoc DISCLAIMER.TXT UPGRADE.TXT README.TXT doc/changelog*

	cp -R LICENSE.TXT [[:lower:]][[:lower:]]* ${D}/${MY_HTDOCSDIR}

	local files="files include lang smileys themes"
	for a in files; do
		webapp_serverowned ${MY_HTDOCSDIR}/${a}
	done
	webapp_serverowned ${MY_HTDOCSDIR}

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
