# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/polarblog/polarblog-1.02.ebuild,v 1.4 2004/08/30 19:41:12 rl03 Exp $

inherit webapp

MY_PV=${PV/./}
S=${WORKDIR}/PB_v${MY_PV}

IUSE=""

DESCRIPTION="PolarBlog is an open source embedded weblog solution"
HOMEPAGE="http://polarblog.polarlava.com"
SRC_URI="http://polarblog.polarlava.com/releases/pb_v${MY_PV}.tgz"
KEYWORDS="~x86"

RDEPEND="
	>=dev-db/mysql-3.23.23
	>=virtual/php-4
"

LICENSE="GPL-2"

src_install() {
	webapp_src_preinst

	dodoc CHANGES INSTALL README

	cp -R [[:lower:]][[:lower:]]* ${D}/${MY_HTDOCSDIR}
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_src_install
}
