# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libtermcap-compat/libtermcap-compat-1.2.3.ebuild,v 1.21 2004/09/25 00:44:41 pvdabeel Exp $

MY_PN="termcap-compat"
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="Compatibility package for old termcap-based programs"
SRC_URI="http://ftp.debian.org/debian/dists/potato/main/source/oldlibs/${MY_PN}_${PV}.tar.gz"
HOMEPAGE="http://packages.debian.org/stable/oldlibs/termcap-compat.html"

IUSE=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa mips"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}; patch -p0 < ${FILESDIR}/${PN}_bcopy_fix.patch || die
}

src_compile() {
	emake prefix="/" \
		CFLAGS="${CFLAGS} -I." || die
}

src_install () {
	dodir /lib /include /usr/lib
	make prefix="${D}" install || die

	# Conflicts with ncurses.
	rm -rf ${D}/include

	cd ${D}/lib; mv libtermcap.a ../usr/lib
	# Make sure we link to /lib/libtermcap.so, not /usr/lib/libtermcap.a,
	# bug #4411.
	gen_usr_ldscript libtermcap.so
	dosym libtermcap.so.2.0.8 /lib/libtermcap.so

	insinto /etc
	newins ${S}/termtypes.tc termcap

	cd ${S}
	dodoc ChangeLog README
}

