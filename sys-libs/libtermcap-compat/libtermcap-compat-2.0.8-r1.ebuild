# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libtermcap-compat/libtermcap-compat-2.0.8-r1.ebuild,v 1.1 2004/03/17 18:29:46 aliz Exp $

inherit eutils

PATCHVER=0.1

MY_PN="${PN/lib/}"
MY_PN="${MY_PN/-compat/}"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"
PATCHDIR="${WORKDIR}/patch"
DESCRIPTION="Compatibility package for old termcap-based programs"
HOMEPAGE="http://www.catb.org/~esr/terminfo/"
SRC_URI="http://www.catb.org/~esr/terminfo/termtypes.tc.gz
	http://dev.gentoo.org/~seemant/extras/${MY_P}.tar.bz2
	http://dev.gentoo.org/~seemant/extras/${P}-gentoo-${PATCHVER}.tar.bz2
	mirror://gentoo/${MY_P}.tar.bz2
	mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2"

SLOT="0"
LICENSE="freedist"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64 ~ppc64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}
	mv termtypes.tc termcap
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}/tc.file

	cd ${S}; epatch ${FILESDIR}/${PN}_bcopy_fix.patch
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}

	epatch ${FILESDIR}/${P}-fPIC.patch
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
	# Make sure we link to /lib/libtermcap.so, not /usr/lib/libtermcap.a,
	# bug #4411.
	gen_usr_ldscript libtermcap.so
	dosym libtermcap.so.${PV} /lib/libtermcap.so

	insinto /etc
	doins ${WORKDIR}/termcap

	cd ${S}
	dodoc ChangeLog README
}

