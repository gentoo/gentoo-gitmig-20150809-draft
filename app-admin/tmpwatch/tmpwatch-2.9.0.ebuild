# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tmpwatch/tmpwatch-2.9.0.ebuild,v 1.11 2004/12/28 11:46:55 ka0ttic Exp $

RPM_V="2"

DESCRIPTION="Utility recursively searches through specified directories and removes files which have not been accessed in a specified period of time."
HOMEPAGE="http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/"
SRC_URI="http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/${P}-${RPM_V}.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha ia64 ~amd64 ppc64"
IUSE=""

DEPEND="virtual/libc
	app-arch/rpm2targz"

src_unpack() {
	cd ${WORKDIR}
	rpm2targz ${DISTDIR}/${P}-${RPM_V}.src.rpm || die "rpm2targz failed"
	tar zxf ${P}-${RPM_V}.src.tar.gz || die
	tar zxf ${P}.tar.gz || die

	cd ${S}
	sed -i "s:..RPM_OPT_FLAGS.:${CFLAGS}:" Makefile \
		|| die "sed Makefile failed"
	sed -i 's|/sbin/fuser|/bin/fuser|' tmpwatch.c \
		|| die "sed tmpwatch.c failed"
	sed -i 's|/sbin|/bin|' tmpwatch.8 || die "sed tmpwatch.8 failed"
}

src_install() {
	preplib /usr
	dosbin tmpwatch || die "dosbin failed"
	doman tmpwatch.8 || die "doman failed"
}
