# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/queue-fix/queue-fix-1.4-r2.ebuild,v 1.7 2004/04/10 04:32:34 kumba Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Qmail Queue Repair Application with support for big-todo"
SRC_URI="http://www.netmeridian.com/e-huss/${P}.tar.gz
		mirror://qmail/queue-fix-todo.patch"
HOMEPAGE="http://www.netmeridian.com/e-huss/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 alpha ~hppa mips ppc sparc amd64 ia64"
IUSE=""
DEPEND="sys-devel/gcc-config"
RDEPEND="|| ( net-mail/qmail
			  net-mail/qmail-mysql
			  net-mail/qmail-ldap
			)"

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${DISTDIR}/queue-fix-todo.patch
	sed -i 's/^extern int errno;/#include <errno.h>/' ${S}/error.h
	sed -i 's/head -1/head -n1/' ${S}/Makefile
}

src_compile() {
	echo "${CC} ${CFLAGS}" > conf-cc
	echo "${CC} ${LDFLAGS}" > conf-ld
	emake || die
}

src_install () {
	into /var/qmail
	dobin queue-fix
	into /usr
	dodoc README CHANGES
}

