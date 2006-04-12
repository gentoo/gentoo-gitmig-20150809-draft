# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/viewcvs/viewcvs-0.9.4.ebuild,v 1.4 2006/04/12 00:08:38 vapier Exp $

inherit webapp

DESCRIPTION="a web interface to cvs and subversion"
HOMEPAGE="http://viewcvs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="viewcvs"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="cvsgraph enscript"

RDEPEND="|| (
		>=dev-util/cvs-1.11
		dev-util/subversion
	)
	dev-lang/python
	>=app-text/rcs-5.7
	sys-apps/diffutils
	cvsgraph? ( dev-util/cvsgraph )
	enscript? ( app-text/enscript )
	net-www/apache"

src_install() {
	webapp_src_preinst
	dodir ${MY_CGIBINDIR}/${PN} ${MY_HOSTROOTDIR}/${PN}

	exeinto ${MY_CGIBINDIR}/${PN}
	doexe cgi/viewcvs.cgi cgi/query.cgi standalone.py

	cp -r lib/ ${D}/${MY_HOSTROOTDIR}/${PN}/
	cp -r templates/ ${D}/${MY_HOSTROOTDIR}/${PN}/
	cp -r tools/ ${D}/${MY_HOSTROOTDIR}/${PN}/
	cp -r tests/ ${D}/${MY_HOSTROOTDIR}/${PN}/
	insinto ${MY_HOSTROOTDIR}/${PN}
	newins cgi/viewcvs.conf.dist viewcvs.conf
	newins cgi/cvsgraph.conf.dist cvsgraph.conf

	dodoc INSTALL TODO CHANGES README
	dohtml -r website/*
	dosym /usr/share/doc/${PF}/html ${MY_HTDOCSDIR}/doc

	webapp_configfile ${MY_HOSTROOTDIR}/${PN}/viewcvs.conf
	webapp_configfile ${MY_HOSTROOTDIR}/${PN}/cvsgraph.conf
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_src_install
}
