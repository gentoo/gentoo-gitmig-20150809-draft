# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/issue-tracker/issue-tracker-4.0.3-r1.ebuild,v 1.1 2004/09/08 15:58:15 karltk Exp $

inherit webapp

DESCRIPTION="Issue tracking system"
HOMEPAGE="http://www.issue-tracker.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="$DEPEND"
RDEPEND="virtual/php
	|| ( dev-db/mysql dev-db/postgresql )"

src_unpack() {
	unpack ${A}
	sed -r 's/(Could not.*_URL_.*manually.*)\"\);/\1\";/' -i ${S}/conf/const.php || die
}

src_install() {
	webapp_src_preinst
	cd ${S}

	dodoc docs/*

	# copy over everything but docs
	cp -R [ch-z]* ${D}/${MY_HTDOCSDIR}
	cp -R download ${D}/${MY_HTDOCSDIR}
	# the following needs to be serverowned as per Edwin Robertson <tm@tuxmonkey.com>
	local MY_FILES="sessions logs download css themes"
	for file in ${MY_FILES}; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done
	for file in `find cache -type d`; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
#	webapp_hook_script ${FILESDIR}/reconfig

	webapp_src_install
}
