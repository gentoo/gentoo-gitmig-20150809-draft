# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam_mysql/pam_mysql-0.4.7.ebuild,v 1.5 2003/06/21 22:06:04 drobbins Exp $

DESCRIPTION="pam_mysql is a module for pam to authenticate users with mysql"
HOMEPAGE="http://pam-mysql.sourceforge.net/"

S="${WORKDIR}/${PN}"
SRC_URI="mirror://sourceforge/pam-mysql/${P}.tar.gz"
DEPEND=">=sys-libs/pam-0.72 >=dev-db/mysql-3.23.38"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	cp Makefile Makefile.orig
	sed -e "s%-O2%${CFLAGS}%" Makefile.orig > Makefile
	#i dont think this is needed --woodchip
	#-e 's%^\(export LD_D=.*\)%\1 -lz%' \
}

src_compile() {
	emake || die
}

src_install() {
	exeinto /lib/security
	doexe pam_mysql.so
	dodoc Changelog CREDITS Readme
}
