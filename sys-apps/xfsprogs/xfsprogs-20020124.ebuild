# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xfsprogs/xfsprogs-20020124.ebuild,v 1.1 2002/01/24 08:02:08 drobbins Exp $

S=${WORKDIR}/cmd/${PN}
DESCRIPTION="xfs filesystem utilities"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/xfs-cmd-${PV}.tar.bz2"
HOMEPAGE="http://oss.sgi.com/projects/xfs"

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
}
