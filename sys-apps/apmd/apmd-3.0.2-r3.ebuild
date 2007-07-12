# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apmd/apmd-3.0.2-r3.ebuild,v 1.22 2007/07/12 05:10:21 mr_bones_ Exp $

inherit eutils

IUSE="X nls"

S=${WORKDIR}/${PN}
DESCRIPTION="Advanced Power Management Daemon"
HOMEPAGE="http://www.worldvisions.ca/~apenwarr/apmd/"
SRC_URI="http://www.worldvisions.ca/~apenwarr/apmd/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc"

DEPEND=">=sys-apps/debianutils-1.16
	X? ( || ( ( x11-libs/libX11
				x11-libs/libXaw
				x11-libs/libXmu
				x11-libs/libSM
				x11-libs/libICE
				x11-libs/libXt
				x11-libs/libXext )
				virtual/x11 ) )"

src_unpack() {
	unpack ${A} ; cd ${S}

	cp Makefile Makefile.orig
	sed -e "s:\(PREFIX=\)\(/usr\):\1\$\{DESTDIR\}\2:" \
		-e "s:\(APMD_PROXY_DIR\=\)\(/etc\):\1\$\{DESTDIR\}\2/apm:" \
		-e "97d" \
		-e "s:\(MANDIR\=\${PREFIX}\)\(/man\):\1/share\2:" \
		Makefile.orig > Makefile

	if use X ; then
		echo -e "xinstall:\n\tinstall\txapm\t\${PREFIX}/bin" >> Makefile
	else
		cp Makefile Makefile.orig
		sed -e "/^EXES=/s/xapm//" \
			-e "/install.*xapm/d" \
			Makefile.orig > Makefile
	fi

	# This closes bug #1472: fixes compilation with recent 2.4 kernels
	epatch ${FILESDIR}/apmsleep.c.diff

	# This closes bug #29636: needs 2.6 patching [plasmaroo@gentoo.org]
	epatch ${FILESDIR}/apmd.kernel26x.patch

}

src_compile() {
	make CFLAGS="${CFLAGS}" || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	dodir /etc/apm/{event.d,suspend.d,resume.d}
	exeinto /etc/apm ; doexe debian/apmd_proxy
	dodoc ANNOUNCE BUGS.apmsleep COPYING* README* ChangeLog LSM

	newconfd ${FILESDIR}/apmd.confd apmd
	newinitd ${FILESDIR}/apmd.rc6 apmd

	if use X ; then
		make DESTDIR=${D} xinstall || die "xinstall failed"
	fi

	if ! use nls
	then
		rm -rf ${D}/usr/share/man/fr
	fi
}
