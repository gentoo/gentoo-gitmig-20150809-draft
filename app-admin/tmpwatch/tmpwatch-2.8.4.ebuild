# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tmpwatch/tmpwatch-2.8.4.ebuild,v 1.11 2004/12/28 11:46:55 ka0ttic Exp $

RPM_V="4"

DESCRIPTION="Utility recursively searches through specified directories and removes files which have not been accessed in a specified period of time."
HOMEPAGE="ftp://ftp.redhat.com/pub/redhat/linux/rawhide/SRPMS/SRPMS"
SRC_URI="ftp://ftp.redhat.com/pub/redhat/linux/rawhide/SRPMS/SRPMS/${P}-${RPM_V}.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc
	app-arch/rpm2targz"

src_unpack() {
	cd ${WORKDIR}
	rpm2targz ${DISTDIR}/${P}-${RPM_V}.src.rpm || die "rpm2targz failed"
	tar zxf ${P}-${RPM_V}.src.tar.gz || die
	tar zxf ${P}.tar.gz || die

	cd ${S}
	sed -i "s:..RPM_OPT_FLAGS.:${CFLAGS}:" Makefile || die "sed failed"
}

src_install() {
	preplib /usr
	dosbin tmpwatch || die "dosbin failed"
	doman tmpwatch.8 || die "doman failed"
}
