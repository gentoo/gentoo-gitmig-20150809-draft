# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/queue-fix/queue-fix-1.4-r1.ebuild,v 1.5 2004/07/15 02:23:37 agriffis Exp $

inherit eutils

DESCRIPTION="Qmail Queue Repair Application with support for big-todo"
SRC_URI="http://www.netmeridian.com/e-huss/${P}.tar.gz
		mirror://qmail/queue-fix-todo.patch"
HOMEPAGE="http://www.netmeridian.com/e-huss/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"
IUSE=""
DEPEND="sys-devel/gcc-config"
PDEPEND="mail-mta/qmail"

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${DISTDIR}/queue-fix-todo.patch
	cd ${S}
	cp error.h error.h.orig
	sed 's/^extern int errno;/#include <errno.h>/' <error.h.orig >error.h
}

src_compile() {
	cd ${S}
	echo "${CC} ${CFLAGS}" > conf-cc
	echo "${CC} ${LDFLAGS}" > conf-ld
	emake || die
}

src_install () {
	insinto /var/qmail/bin
	doins queue-fix
	dodoc README CHANGES
}
