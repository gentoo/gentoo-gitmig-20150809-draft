# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pax-utils/pax-utils-0.0.8.ebuild,v 1.2 2005/05/23 08:17:24 vapier Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Various ELF related utils for ELF32, ELF64 binaries useful for displaying PaX and security info on a large groups of bins"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened"
SRC_URI="mirror://gentoo/pax-utils-${PV}.tar.gz
	http://dev.gentoo.org/~solar/pax/pax-utils-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="caps"

DEPEND="caps? ( sys-libs/libcap )"

S=${WORKDIR}/${PN}

src_compile() {
	if use caps ; then
		append-flags -DWANT_SYSCAP
		append-ldflags -lcap
	fi
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" all || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README
}
