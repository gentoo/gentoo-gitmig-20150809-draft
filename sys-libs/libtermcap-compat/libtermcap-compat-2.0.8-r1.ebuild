# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libtermcap-compat/libtermcap-compat-2.0.8-r1.ebuild,v 1.13 2006/08/29 11:27:28 blubb Exp $

inherit eutils multilib toolchain-funcs

PATCHVER=0.1

MY_PN="${PN/lib/}"
MY_PN="${MY_PN/-compat/}"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"
PATCHDIR="${WORKDIR}/patch"
DESCRIPTION="Compatibility package for old termcap-based programs"
HOMEPAGE="http://www.catb.org/~esr/terminfo/"
SRC_URI="http://www.catb.org/~esr/terminfo/termtypes.tc.gz
	mirror://gentoo/${MY_P}.tar.bz2
	mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="virtual/libc"

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
	dodir /$(get_libdir) /include /usr/$(get_libdir)
	make prefix="${D}" OWNER="root:root" install || die

	# Conflicts with ncurses.
	rm -rf ${D}/include

	cd ${D}/$(get_libdir); mv libtermcap.a ../usr/$(get_libdir)
	# Make sure we link to /lib/libtermcap.so, not /usr/lib/libtermcap.a,
	# bug #4411.
	gen_usr_ldscript libtermcap.so
	dosym libtermcap.so.2 /$(get_libdir)/libtermcap.so
	dosym libtermcap.so.${PV} /$(get_libdir)/libtermcap.so.2
	
	cd ${D} ; rm ./lib

	insinto /etc
	doins ${WORKDIR}/termcap

	cd ${S}
	dodoc ChangeLog README
}
