# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mysql/mysql-1.1.ebuild,v 1.1 2007/01/04 20:11:34 vivo Exp $

DESCRIPTION="Install gentoo related MySQL stuff"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	insinto "/etc/conf.d"
	newins "${FILESDIR}/mysql.conf.d" "mysql"
	newins "${FILESDIR}/mysqlmanager.conf.d" "mysqlmanager"

	exeinto /etc/init.d
	newexe "${FILESDIR}/mysql.rc6-r1" "mysql"
	newexe "${FILESDIR}/mysqlmanager.rc6" "mysqlmanager"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/logrotate.mysql" "mysql"
}
