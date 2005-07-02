# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_mysql/pam_mysql-0.5.ebuild,v 1.1 2005/07/02 14:24:30 flameeyes Exp $

DESCRIPTION="pam_mysql is a module for pam to authenticate users with mysql"
HOMEPAGE="http://pam-mysql.sourceforge.net/"

S="${WORKDIR}/${PN}"
SRC_URI="mirror://sourceforge/pam-mysql/${P}.tar.gz"
DEPEND=">=sys-libs/pam-0.72 >=dev-db/mysql-3.23.38"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha ~amd64"
IUSE=""

src_unpack() {
	unpack ${A} || die
	cd ${S} || die

	cp Makefile Makefile.orig
	sed -e "s%-O2%${CFLAGS}%" Makefile.orig > Makefile
	#i dont think this is needed --woodchip
	#-e 's%^\(export LD_D=.*\)%\1 -lz%' \

	cp pam_mysql.c pam_mysql.c.orig
	sed -e "s%#define DEBUG%%" pam_mysql.c.orig > pam_mysql.c
}

src_compile() {
	emake || die
}

src_install() {
	exeinto /lib/security
	doexe pam_mysql.so
	dodoc Changelog CREDITS Readme
}
