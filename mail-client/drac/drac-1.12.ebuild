# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/drac/drac-1.12.ebuild,v 1.6 2004/10/26 18:30:08 slarti Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A robust implementation of POP-before-SMTP"
HOMEPAGE="http://mail.cc.umanitoba.ca/drac/"
SRC_URI="ftp://ftp.cc.umanitoba.ca/src/${PN}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE="debug"

DEPEND="virtual/libc
	sys-libs/db
	>=mail-mta/sendmail-8.9"

S=${WORKDIR}

src_compile() {
	cp Makefile Makefile.orig
	sed \
		-e "s:INSTALL = /usr/ucb/install:INSTALL = install:" \
		-e "s:EBIN = /usr/local/sbin:EBIN = /usr/sbin:" \
		-e "s:MAN = /usr/local/man/man:MAN = /usr/share/man/man:" \
		-e "s:DEFS = -DTI_RPC -DFCNTL_LOCK -DSYSINFO:DEFS = -DSOCK_RPC -DFCNTL_LOCK -DGETHOST -DDASH_C:" \
		-e "s:CC = cc:CC = $(tc-getCC):" \
		-e "s:LDLIBS = -L/usr/local/src/db/db-4.1.25/build_unix -lnsl -ldb-4.1:LDLIBS = -ldb:" \
		-e "s:TSTLIBS = -L. -ldrac -lnsl:TSTLIBS = -L. -ldrac:" \
		-e "s:RPCGENFLAGS =:RPCGENFLAGS = -C -I:" \
		-e "s:MANADM = 1m:MANADM = 8:" \
		< Makefile.orig > Makefile
	if use debug; then
		cp Makefile Makefile.posthacked
		sed -e "s:CFLAGS = \$(DEFS) -g -I/usr/local/src/db/db-4.1.25/build_unix:CFLAGS = \$(DEFS) -g ${CFLAGS}:" \
			< Makefile.posthacked > Makefile
	else
		cp Makefile Makefile.posthacked
		sed -e "s:CFLAGS = \$(DEFS) -g -I/usr/local/src/db/db-4.1.25/build_unix:CFLAGS = \$(DEFS) ${CFLAGS}:" \
			< Makefile.posthacked > Makefile
	fi
	make || die
}

src_install() {
	dobin rpc.dracd
	mv rpc.dracd.1m rpc.dracd.8
	doman dracauth.3 rpc.dracd.8
}
