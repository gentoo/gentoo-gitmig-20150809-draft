# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/dotproject/dotproject-2.1.2-r1.ebuild,v 1.1 2009/01/26 19:05:24 pva Exp $

inherit eutils webapp depend.php

DESCRIPTION="dotProject is a PHP web-based project management framework"
HOMEPAGE="http://www.dotproject.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/dotproject-2.1.2-r5791_5840.patch.bz2"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
IUSE=""

DEPEND=""
RDEPEND="app-text/poppler"

need_httpd_cgi
need_php_httpd

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${P}-r5791_5840.patch"
}

src_install () {
	webapp_src_preinst

	dodoc ChangeLog README
	rm -f ChangeLog README

	mv includes/config{-dist,}.php

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned "${MY_HTDOCSDIR}"/includes/config.php
	webapp_serverowned "${MY_HTDOCSDIR}"/files{,/temp}
	webapp_serverowned "${MY_HTDOCSDIR}"/locales/en

	webapp_postinst_txt en "${FILESDIR}"/install-en.txt
	webapp_src_install
}
