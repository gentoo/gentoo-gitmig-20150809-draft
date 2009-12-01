# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/syweb/syweb-0.59.ebuild,v 1.1 2009/12/01 18:31:23 tcunha Exp $

WEBAPP_MANUAL_SLOT="yes"

inherit depend.php webapp

DESCRIPTION="Web frontend to symon"
HOMEPAGE="http://www.xs4all.nl/~wpd/symon/"
SRC_URI="http://www.xs4all.nl/~wpd/symon/philes/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="net-analyzer/rrdtool"

need_httpd_cgi
need_php_httpd

S=${WORKDIR}/${PN}

src_install() {
	webapp_src_preinst

	dodoc CHANGELOG README || die "dodoc failed"
	docinto layouts
	dodoc symon/*.layout || die "dodoc layouts failed"

	dodir "${MY_HOSTROOTDIR}"/syweb/cache
	insinto "${MY_HOSTROOTDIR}"/syweb
	doins symon/hifn_test.layout || die "doins hifn_test.layout failed"
	webapp_serverowned "${MY_HOSTROOTDIR}"/syweb/cache
	insinto "${MY_HTDOCSDIR}"
	doins -r htdocs/syweb/* || die "doins htdocs failed"
	webapp_configfile "${MY_HTDOCSDIR}"/setup.inc
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_hook_script "${FILESDIR}"/reconfig

	webapp_src_install
}
