# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ltrace/ltrace-0.3.31.ebuild,v 1.14 2005/02/10 12:16:00 ka0ttic Exp $

inherit eutils

DESCRIPTION="ltrace shows runtime library call information for dynamically linked executables"
HOMEPAGE="http://packages.debian.org/unstable/utils/ltrace.html"
SRC_URI="mirror://debian/pool/main/l/ltrace/${PN}_${PV}.tar.gz
	amd64?( http://gentoo.tamperd.net/distfiles/ltrace-0.3.26-x86_64.tar.bz2
		mirror://gentoo/ltrace-0.3.26-x86_64.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc -sparc ~alpha ~hppa ~mips ~amd64 ~ia64"
IUSE=""

DEPEND=">=sys-apps/sed-4
	virtual/libc"

src_unpack() {
	unpack ${PN}_${PV}.tar.gz ; cd ${S}

	if [ "${ARCH}" == "amd64" ]; then
		unpack ltrace-0.3.26-x86_64.tar.bz2
	fi

	epatch ${FILESDIR}/${P}-64bit-fixes.patch
}

src_compile() {
	econf || die

	# modify CFLAGS (hopefully in a more time friendly way)
	sed -i "s/ -O2 / ${CFLAGS} /" Makefile

	emake all || make all || die
}

src_install() {
	einstall || die

	# documentation
	rm -rvf ${D}usr/doc/
	dodoc BUGS COPYING debian/changelog README TODO
}
