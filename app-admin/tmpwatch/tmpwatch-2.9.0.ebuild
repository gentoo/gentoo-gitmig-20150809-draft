# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tmpwatch/tmpwatch-2.9.0.ebuild,v 1.3 2004/04/06 19:09:00 agriffis Exp $

RPM_V="2"

DESCRIPTION="Utility recursively searches through specified directories and removes files which have not been accessed in a specified period of time."
SRC_URI="ftp://ftp.redhat.com/pub/redhat/linux/rawhide/SRPMS/SRPMS/${P}-${RPM_V}.src.rpm"
HOMEPAGE="ftp://ftp.redhat.com/pub/redhat/linux/rawhide/SRPMS/SRPMS"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc alpha ia64"

DEPEND="virtual/glibc
	app-arch/rpm2targz"

src_unpack() {
	cd ${WORKDIR}
	rpm2targz ${DISTDIR}/${P}-${RPM_V}.src.rpm
	tar zxf ${P}-${RPM_V}.src.tar.gz
	tar zxf ${P}.tar.gz

	cd ${S}
	sed -i "s:..RPM_OPT_FLAGS.:${CFLAGS}:" Makefile
	sed -i 's|/sbin/fuser|/bin/fuser|' tmpwatch.c
	sed -i 's|/sbin|/bin|' tmpwatch.8
}

src_compile() {
	emake || die
}

src_install() {
	preplib /usr

	dosbin tmpwatch
	doman tmpwatch.8
}
