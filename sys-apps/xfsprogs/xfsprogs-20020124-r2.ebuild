# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xfsprogs/xfsprogs-20020124-r2.ebuild,v 1.3 2002/07/14 19:20:20 aliz Exp $

S=${WORKDIR}/cmd/${PN}
DESCRIPTION="xfs filesystem utilities"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/xfs-cmd-${PV}.tar.bz2"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
KEYWORDS="x86"
SLOT="0"
LICENSE="LGPL-2.1"
LICENSE="GPL-2"

DEPEND="virtual/glibc sys-devel/autoconf sys-devel/make sys-apps/e2fsprogs"
RDEPEND="virtual/glibc"

src_compile() {
	cd ${S}
	export OPTIMIZER="${CFLAGS}"
	export DEBUG=-DNDEBUG
	autoconf || die
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	make DESTDIR=${D} DK_INC_DIR=${D}/usr/include/disk install install-dev || die
	dodir /lib
	cd ${D}/usr/lib
	local x
	for x in libhandle*
	do
	ln -s ../usr/lib/${x} ${D}/lib/${x}
	done
}
