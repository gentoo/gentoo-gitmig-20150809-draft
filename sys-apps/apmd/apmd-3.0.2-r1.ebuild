# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apmd/apmd-3.0.2-r1.ebuild,v 1.9 2003/06/21 21:19:39 drobbins Exp $

IUSE="X"

DESCRIPTION="Advanced Power Management Daemon"
HOMEPAGE="http://www.worldvisions.ca/~apenwarr/apmd/"
KEYWORDS="x86 amd64"
SLOT="0"
SRC_URI="http://www.worldvisions.ca/~apenwarr/apmd/${P}.tar.gz"
S=${WORKDIR}/${PN}
LICENSE="GPL-2 LGPL-2"

DEPEND="virtual/glibc
	>=sys-apps/debianutils-1.16
	X? ( virtual/x11 )"

src_unpack() {

	unpack ${A} ; cd ${S}

	cp Makefile Makefile.orig
	sed -e "s:\(PREFIX=\)\(/usr\):\1\$\{DESTDIR\}\2:" \
		-e "s:\(APMD_PROXY_DIR\=\)\(/etc\):\1\$\{DESTDIR\}\2/apm:" \
		-e "97d" \
		-e "s:\(MANDIR\=\${PREFIX}\)\(/man\):\1/share\2:" \
		Makefile.orig > Makefile

	if [ "`use X`" ] 
	then
		cp Makefile Makefile.orig
		sed -e "/^EXES=/s/xapm//" \
			-e "/install.*xapm/d" \
			Makefile.orig > Makefile
	fi
}

src_compile() {

	make CFLAGS="${CFLAGS}" || die "compile problem"
}

src_install () {

	make DESTDIR=${D} install || die

	dodir /etc/apm/{event.d,suspend.d,resume.d}
	exeinto /etc/apm ; doexe debian/apmd_proxy
	dodoc ANNOUNCE BUGS.apmsleep COPYING* README* ChangeLog LSM

	insinto /etc/conf.d ; newins ${FILESDIR}/apmd.confd apmd
	exeinto /etc/init.d ; newexe ${FILESDIR}/apmd.rc6 apmd
}
