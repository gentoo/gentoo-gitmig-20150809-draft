# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/viewcvs/viewcvs-0.9.2_p20030430-r2.ebuild,v 1.2 2004/08/30 19:45:27 rl03 Exp $

inherit webapp

PDATE=${PV/0.9.2_p/}
DESCRIPTION="Viewcvs, a web interface to cvs and subversion"
HOMEPAGE="http://viewcvs.sourceforge.net/"
SRC_URI="mirror://gentoo/${PN}-${PDATE}.tar.bz2"

LICENSE="viewcvs"
KEYWORDS="~x86"
IUSE=""

RDEPEND="|| ( ( >=app-text/rcs-5.7
	>=dev-util/cvs-1.11 )
	dev-util/subversion )
	sys-apps/diffutils
	net-www/apache"
S=${WORKDIR}/${PN}

src_install() {
	webapp_src_preinst
	dodir ${MY_CGIBINDIR}/${PN} ${MY_HOSTROOTDIR}/${PN}

	cp cgi/viewcvs.cgi cgi/query.cgi standalone.py tools/loginfo-handler tools/cvsdbadmin tools/make-database ${D}/${MY_CGIBINDIR}/${PN}
	cp -R lib ${D}/${MY_CGIBINDIR}/${PN}
	cp -R templates ${D}/${MY_HOSTROOTDIR}/${PN}
	cp cgi/viewcvs.conf.dist cgi/cvsgraph.conf.dist ${D}/${MY_HOSTROOTDIR}/${PN}

	chmod +x ${D}/${MY_CGIBINDIR}/${PN}/*
	dohtml -r website/*
	dosym /usr/share/doc/${PF}/html ${MY_HTDOCSDIR}/doc

	dodoc INSTALL TODO CHANGES README
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_src_install
}
