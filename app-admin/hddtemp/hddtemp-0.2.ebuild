# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/hddtemp-0.2.ebuild,v 1.14 2003/05/09 21:43:56 mholzer Exp $

DESCRIPTION="A simple utility to read the temperature of SMART IDE hard drives"
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
	patch -p0 < ${FILESDIR}/hddtemp-0.2-db_location.patch

	# patch Makefile
	mv Makefile Makefile.orig
	sed -e "s:^CFLAGS.*:CFLAGS=${CFLAGS} -DARCH_I386:" \
		-e "s:^CC.*:CC=gcc:" \
		Makefile.orig > Makefile
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
