# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libtermcap-compat/libtermcap-compat-1.2.3-r1.ebuild,v 1.6 2004/01/05 22:41:43 seemant Exp $

inherit eutils

MY_PN=${PN/lib/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Compatibility package for old termcap-based programs"
HOMEPAGE="http://packages.debian.org/stable/oldlibs/termcap-compat.html"
SRC_URI="http://ftp.debian.org/debian/dists/potato/main/source/oldlibs/${MY_PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 alpha sparc ppc hppa mips arm ia64 ~amd64 ~ppc64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}; epatch ${FILESDIR}/${PN}_bcopy_fix.patch
}

src_compile() {
	emake prefix="/" CFLAGS="${CFLAGS} -I." || die
}

src_install () {
	dodir /lib /include /usr/lib
	make prefix="${D}" OWNER="root:root" install || die

	# Conflicts with ncurses.
	rm -rf ${D}/include

	cd ${D}/lib; mv libtermcap.a ../usr/lib
	dosym libtermcap.so.2.0.8 /lib/libtermcap.so

	insinto /etc
	newins ${S}/termtypes.tc termcap

	cd ${S}
	dodoc ChangeLog README
}

