# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mediawiki/mediawiki-1.3.8.ebuild,v 1.1 2004/11/16 17:43:11 trapni Exp $

inherit webapp

DESCRIPTION="The MediaWiki wiki web application (as used on wikipedia.org)"
HOMEPAGE="http://www.mediawiki.org"
SRC_URI="mirror://sourceforge/wikipedia/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/php
		>=dev-db/mysql-4"
S=${WORKDIR}/${P}

src_install() {
	webapp_src_preinst

	dodoc ${S}/docs/*
	rm -rf "${S}/docs"

	local DOCS="COPYING HISTORY INSTALL README RELEASE-NOTES UPGRADE AdminSettings.sample"
	for DOC in ${DOCS}; do
		dodoc "${DOC}"
		rm -f "${DOC}"
	done

	cp -ap * "${D}/${MY_HTDOCSDIR}"

	webapp_serverowned "${MY_HTDOCSDIR}/config"
	webapp_serverowned "${MY_HTDOCSDIR}/images"

	webapp_src_install
}
