# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apmd/apmd-3.0.2-r3.ebuild,v 1.3 2002/07/21 18:22:55 gerk Exp $

DESCRIPTION="Advanced Power Management Daemon"
HOMEPAGE="http://www.worldvisions.ca/~apenwarr/apmd/"
KEYWORDS="x86 -ppc"
SRC_URI="http://www.worldvisions.ca/~apenwarr/apmd/${P}.tar.gz"
S=${WORKDIR}/${PN}

DEPEND="virtual/glibc >=sys-apps/debianutils-1.16 X? ( virtual/x11 )"
RDEPEND=${DEPEND}
LICENSE="GPL"
SLOT=0
KEYWORD="x86"

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
		echo -e "xinstall:\n\tinstall\txapm\t\${PREFIX}/bin" >> Makefile
		
	else

		cp Makefile Makefile.orig
		sed -e "/^EXES=/s/xapm//" \
			-e "/install.*xapm/d" \
			Makefile.orig > Makefile
	fi

	#This closes bug #1472: fixes compilation with recent 2.4 kernels
	cat ${FILESDIR}/apmsleep.c.diff | patch -p0 -l || die
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

	if [ "`use X`" ]
	then
		make DESTDIR=${D} xinstall || die
	fi
}
