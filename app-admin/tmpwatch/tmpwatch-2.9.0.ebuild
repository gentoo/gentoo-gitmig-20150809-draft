# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tmpwatch/tmpwatch-2.9.0.ebuild,v 1.10 2004/09/18 19:47:15 ka0ttic Exp $

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
