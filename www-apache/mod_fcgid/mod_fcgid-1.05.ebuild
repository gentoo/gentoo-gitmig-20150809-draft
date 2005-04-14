# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_fcgid/mod_fcgid-1.05.ebuild,v 1.1 2005/04/14 17:54:54 ramereth Exp $

DESCRIPTION="mod_fcgid is a binary-compatible alternative to mod_fastcgi
with better process management"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

MY_P=${PN}.${PV}

HOMEPAGE="http://fastcgi.coremail.cn/"
SRC_URI="http://fastcgi.coremail.cn/${MY_P}.tar.gz"
LICENSE="GPL-2"
DEPEND=">=net-www/apache-2
	!<=net-www/apache-1"
RDEPEND=">=net-www/apache-2
	!<=net-www/apache-1"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${WORKDIR}
	mv ${MY_P} ${PN}-${PV}
	cd ${S}
	sed -i '/^include/s:$:\nINCLUDES=-I/usr/include/apache2:;/^top_dir/s:local:lib:' Makefile
}

src_install() {
	dodoc AUTHOR ChangeLog INSTALL.txt
	exeinto /usr/lib/apache2-extramodules ; doexe .libs/${PN}.so
	insinto /etc/apache2/conf/modules.d ; doins ${FILESDIR}/20_mod_fcgid.conf
}

pkg_postinst() {
	einfo "Add '-D FCGID' to your APACHE2_OPTS in /etc/conf.d/apache2"
}
