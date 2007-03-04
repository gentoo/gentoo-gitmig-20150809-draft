# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-init-scripts/mysql-init-scripts-1.2.ebuild,v 1.1 2007/03/04 15:47:03 vivo Exp $

DESCRIPTION="Gentoo MySQL init scripts."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	insinto "/etc/conf.d"
	newins "${FILESDIR}/mysql.conf.d" "mysql"
	newins "${FILESDIR}/mysqlmanager.conf.d" "mysqlmanager"

	exeinto /etc/init.d
	newexe "${FILESDIR}/mysql.rc6" "mysql"
	newexe "${FILESDIR}/mysqlmanager.rc6" "mysqlmanager"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/logrotate.mysql" "mysql"
}
