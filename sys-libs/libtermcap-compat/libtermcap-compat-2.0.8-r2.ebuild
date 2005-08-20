# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libtermcap-compat/libtermcap-compat-2.0.8-r2.ebuild,v 1.1 2005/08/20 04:22:41 vapier Exp $

inherit eutils multilib

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
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=""

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
	dodir /lib /include
	make prefix="${D}" OWNER="root:root" install || die

	# Conflicts with ncurses.
	rm -r "${D}"/include

	cd "${D}"/lib
	rm -f libtermcap.{a,so}
	dosym libtermcap.so.${PV} /lib/libtermcap.so.2

	insinto /etc
	doins ${WORKDIR}/termcap

	cd ${S}
	dodoc ChangeLog README
}
