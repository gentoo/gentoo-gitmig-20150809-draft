# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libol/libol-0.3.13.ebuild,v 1.9 2004/06/15 23:59:43 kloeri Exp $

DESCRIPTION="Support library for syslog-ng"
HOMEPAGE="http://www.balabit.hu/en/products/syslog-ng/"
SRC_URI="http://www.balabit.hu/downloads/libol/0.3/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha ~hppa mips ~amd64 ~ia64 ppc64 s390"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND=""

src_compile() {
	econf || die
	# why must people hard-code CFLAGS into configure?
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog || die "dodoc failed"
}
