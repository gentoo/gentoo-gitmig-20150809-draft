# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pax-utils/pax-utils-0.0.2.ebuild,v 1.6 2004/10/05 13:34:52 pvdabeel Exp $

DESCRIPTION="Various PaX related utils for ELF32, ELF64 binaries"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened"
SRC_URI="mirror://gentoo/pax-utils-${PV}.tar.gz
	http://dev.gentoo.org/~solar/pax/pax-utils-${PV}.tar.gz
	http://pageexec.virtualave.net/pax-utils-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~hppa ~amd64 ~ia64"
IUSE="debug"

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	use debug && export STRIP=touch
	emake -j1 CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
