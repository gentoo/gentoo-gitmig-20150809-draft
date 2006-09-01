# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/info2html/info2html-1.4-r2.ebuild,v 1.1 2006/09/01 11:02:44 kevquinn Exp $

inherit eutils webapp

DESCRIPTION="Converts GNU .info files to HTML"
HOMEPAGE="http://info2html.sourceforge.net/"
SRC_URI="mirror://sourceforge/info2html/${P}.tgz"

LICENSE="freedist"
#SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~sparc ~x86"

DEPEND="dev-lang/perl"

#pkg_setup() {
#	webapp_pkg_setup
#}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/info2html-gentoo.patch
	epatch ${FILESDIR}/info2html-xss.patch
}

src_install() {
	webapp_src_preinst

	exeinto ${MY_CGIBINDIR}
	cp info2html infocat info2html.conf ${D}/${MY_CGIBINDIR}
	dodoc README

	webapp_src_install
}
