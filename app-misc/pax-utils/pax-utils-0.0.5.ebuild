# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pax-utils/pax-utils-0.0.5.ebuild,v 1.1 2005/04/02 04:53:33 solar Exp $

inherit flag-o-matic gcc

DESCRIPTION="Various ELF related utils for ELF32, ELF64 binaries useful for displaying PaX and security info on a large groups of bins"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened"
SRC_URI="mirror://gentoo/pax-utils-${PV}.tar.gz
	http://dev.gentoo.org/~solar/pax/pax-utils-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~mips ~sparc ~hppa ~amd64 ~ia64"
IUSE="caps"

DEPEND="virtual/libc
	caps? ( sys-libs/libcap )"

S=${WORKDIR}/${PN}

src_compile() {
	export MAKEOPTS="${MAKEOPTS} -j1"
	if use caps; then
		append-flags -DWANT_SYSCAP
		append-ldflags -lcap
	fi
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" all || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
