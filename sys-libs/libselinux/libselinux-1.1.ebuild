# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libselinux/libselinux-1.1.ebuild,v 1.1 2003/08/14 15:28:31 pebenito Exp $

IUSE=""

DESCRIPTION="SELinux library (libselinux)"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc
	!sys-apps/selinux-small
	sys-apps/attr"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	cd ${S}/src
	emake EXTRA_CFLAGS="${CFLAGS}"

	cd ${S}/utils
	emake EXTRA_CFLAGS="${CFLAGS}"
}

src_install() {
	make DESTDIR="${D}" install
}

