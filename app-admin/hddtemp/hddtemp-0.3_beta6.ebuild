# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/hddtemp-0.3_beta6.ebuild,v 1.1 2003/04/14 23:28:37 mholzer Exp $

MY_P=${P/_beta/-beta}
DESCRIPTION="A simple utility to read the temperature of SMART IDE hard drives"
SRC_URI="http://coredump.free.fr/linux/${MY_P}.tar.gz
	mirror://gentoo/hddtemp.db"
HOMEPAGE="http://coredump.free.fr/linux/harddrive.html"
S=${WORKDIR}/${MY_P}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} ; cd ${S}

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
	insinto /etc
	doins ${DISTDIR}/hddtemp.db
	dodoc README TODO Changelog COPYING
}
