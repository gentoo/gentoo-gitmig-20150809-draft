# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/hddtemp-0.2.ebuild,v 1.17 2004/01/04 16:20:24 weeve Exp $

DESCRIPTION="A simple utility to read the temperature of SMART capable hard drives"
SRC_URI="http://coredump.free.fr/linux/${P}.tar.gz
	mirror://gentoo/hddtemp.db"
HOMEPAGE="http://coredump.free.fr/linux/hddtemp.php"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} ; cd ${S}

	# patch hddtemp.c
	epatch ${FILESDIR}/hddtemp-0.2-db_location.patch

	# patch Makefile
	sed -i -e "s:^CFLAGS.*:CFLAGS=${CFLAGS} -DARCH_I386:" \
		-e "s:^CC.*:CC=gcc:" \
		Makefile
}

src_compile() {
	make || die
}

src_install() {
	dobin hddtemp
	insinto /usr/share/hddtemp
	doins ${DISTDIR}/hddtemp.db
	dodoc README COPYING
}
