# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/hddtemp-0.2.ebuild,v 1.23 2004/06/29 19:37:34 agriffis Exp $

inherit eutils

DESCRIPTION="A simple utility to read the temperature of SMART capable hard drives"
HOMEPAGE="http://coredump.free.fr/linux/hddtemp.php"
SRC_URI="http://coredump.free.fr/linux/${P}.tar.gz
	mirror://gentoo/hddtemp.db"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/sed-4"

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
	dobin hddtemp || die
	insinto /usr/share/hddtemp
	doins ${DISTDIR}/hddtemp.db
	dodoc README
}
