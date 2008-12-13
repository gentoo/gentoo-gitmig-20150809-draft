# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/syweb/syweb-0.58-r1.ebuild,v 1.1 2008/12/13 17:43:49 tcunha Exp $

inherit depend.php eutils webapp

DESCRIPTION="Web frontend to symon"
HOMEPAGE="http://www.xs4all.nl/~wpd/symon/"
SRC_URI="http://www.xs4all.nl/~wpd/symon/philes/${P}.tar.gz"

LICENSE="BSD-2"
WEBAPP_MANUAL_SLOT="yes"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="net-analyzer/rrdtool"

need_httpd_cgi
need_php_httpd

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${PN}-class_lexer.inc.patch	\
	       "${FILESDIR}"/${PN}-setup.inc.patch			\
	       "${FILESDIR}"/${PN}-total_firewall.layout.patch
}

src_install() {
	webapp_src_preinst

	dodoc "${WORKDIR}"/syweb/{CHANGELOG,README} || die "dodoc failed"
	docinto layouts
	dodoc "${WORKDIR}"/syweb/symon/total* || die "dodoc layouts failed"

	dodir "${MY_HOSTROOTDIR}"/${PN}/cache
	keepdir "${MY_HTDOCSDIR}"/layouts
	webapp_serverowned "${MY_HOSTROOTDIR}"/${PN}/cache
	insinto "${MY_HTDOCSDIR}"
	doins -r "${WORKDIR}"/syweb/htdocs/syweb/* || die "doins failed"
	webapp_configfile "${MY_HTDOCSDIR}"/setup.inc
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
