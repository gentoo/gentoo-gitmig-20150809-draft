# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libselinux/libselinux-1.4.ebuild,v 1.2 2003/12/16 20:42:08 pebenito Exp $

IUSE=""

DESCRIPTION="SELinux library (libselinux)"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="sys-libs/glibc"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" src/Makefile \
		|| die "src Makefile CFLAGS fix failed."
	sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" utils/Makefile \
		|| die "utils Makefile CFLAGS fix failed."
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
}
