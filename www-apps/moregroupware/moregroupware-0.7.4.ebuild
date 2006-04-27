# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/moregroupware/moregroupware-0.7.4.ebuild,v 1.1 2006/04/27 18:56:07 rl03 Exp $

inherit webapp

S=${WORKDIR}/${PN}

DESCRIPTION="more.groupware is another web based groupware"
HOMEPAGE="http://moregroupware.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-core-${PV}.tar.gz"

LICENSE="X11 GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/php
	>=dev-db/mysql-3.23
	net-www/apache"

src_install() {
	webapp_src_preinst

	dodoc ChangeLog INSTALL docs/NEWS* docs/TODO

	cp -R . ${D}/${MY_HTDOCSDIR}

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/reconfig

	webapp_src_install
}
