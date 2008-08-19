# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/syweb/syweb-0.58.ebuild,v 1.1 2008/08/19 07:03:00 pva Exp $

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

	epatch "${FILESDIR}"/${PN}-class_lexer.inc.patch
	epatch "${FILESDIR}"/${PN}-setup.inc.patch
	epatch "${FILESDIR}"/${PN}-total_firewall.layout.patch
}

src_install() {
	webapp_src_preinst

	dodoc "${WORKDIR}"/syweb/{CHANGELOG,README} || die "dodoc failed"
	docinto layouts
	dodoc "${WORKDIR}"/syweb/symon/total* || die "dodoc layouts failed"

	dodir "${MY_HTDOCSDIR}"/cache
	dodir "${MY_HTDOCSDIR}"/layouts
	webapp_serverowned "${MY_HTDOCSDIR}"/cache
	insinto "${MY_HTDOCSDIR}"
	doins -r "${WORKDIR}"/syweb/htdocs/syweb/* || die "doins failed"
	webapp_configfile "${MY_HTDOCSDIR}"/setup.inc

	webapp_src_install
}

pkg_postinst() {
	elog "Test your syweb configuration by pointing your browser at:"
	elog "http://${VHOST_HOSTNAME}/${PN}/configtest.php"
	elog "Customize syweb by editing the file setup.inc."
	elog "If you don't want any user interaction, move index_noui.php"
	elog "to index.php."
	elog "NOTE that syweb expects a machine/*.rrd style directory"
	elog "structure under /var/lib/symon/rrds."

	webapp_pkg_postinst
}
