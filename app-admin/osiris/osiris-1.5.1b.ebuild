# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/osiris/osiris-1.5.1b.ebuild,v 1.3 2003/04/23 00:16:29 lostlogic Exp $


DESCRIPTION="File integrity verification system"
HOMEPAGE="http://osiris.shmoo.com/"
SRC_URI="http://osiris.shmoo.com/data/${P}.tar.gz"
LICENSE="OSIRIS"

SLOT="0"
KEYWORDS="~x86 -ppc"

IUSE="mysql"
DEPEND="mysql? ( >=mysql-3.23.54a )"


src_compile() {

	# Osiris provides the necessary gdbm source so that gdbm does not
	# need to be installed to use Osiris. If mysql is set as a USE
	# variable, Osiris will use mysql instead of gdbm.

	einfo "Osiris uses gdbm by default, and will use MySQL if \"mysql\""
	einfo "is set as a USE variable; it cannot be configured to use both."
	
	local myconf
	use mysql && myconf="${myconf} --enable-module=mysql"

	# The mysql module searches for the mysql.h file in the wrong place
	# sed line replaces it with the proper path (mysql/mysql.h)
	
	cp ${S}/src/modules/module_mysql.c ${S}/src/modules/module_mysql.c.old
	use mysql && sed -e "s:mysql.h:mysql/mysql.h:" \
				${S}/src/modules/module_mysql.c.old > ${S}/src/modules/module_mysql.c

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	emake || die
}

src_install() {
	einstall
}
