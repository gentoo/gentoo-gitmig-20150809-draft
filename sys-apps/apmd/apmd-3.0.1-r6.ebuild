# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apmd/apmd-3.0.1-r6.ebuild,v 1.2 2001/12/31 23:47:55 azarah Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${P}
DESCRIPTION="Advanced Power Management Daemon"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/a/apmd/${MY_P}-1.tar.gz"
HOMEPAGE="http://www.worldvisions.ca/~apenwarr/apmd/"

DEPEND="virtual/glibc X? ( virtual/x11 )"

src_unpack() {

	unpack ${A} ; cd ${S}

	cp Makefile Makefile.orig
	sed -e "s:PREFIX=\/usr:PREFIX=\$\{DESTDIR\}\/usr:" \
	    -e "s:APMD_PROXY_DIR\=\/etc:APMD_PROXY_DIR\=\$\{DESTDIR\}\/etc\/apm:" \
	    -e "97d" \
	    -e "s:MANDIR\=\${PREFIX}\/man:MANDIR\=\${PREFIX}\/share\/man:" \
	    Makefile.orig > Makefile

	cp Makefile Makefile.orig2
	use X || sed -e "/^EXES=/s/xapm//" \
			-e "/install.*xapm/d" \
			Makefile.orig2 > Makefile
}

src_compile() {

	make CFLAGS="${CFLAGS}" || die "compile problem"
}

src_install () {

	make DESTDIR=${D} install || die
	dodir /etc/apm/{event.d,suspend.d,resume.d}
	exeinto /etc/apm ; doexe debian/apmd_proxy
	dodoc ANNOUNCE BUGS.apmsleep COPYING* README* ChangeLog LSM

	exeinto /etc/init.d ; newexe ${FILESDIR}/apmd.rc6 apmd
}
