# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/attr/attr-20020124.ebuild,v 1.3 2002/07/11 06:30:50 drobbins Exp $

S=${WORKDIR}/cmd/${PN}
DESCRIPTION="xfs extended attributes tools"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/xfs-cmd-${PV}.tar.bz2"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
LICENSE="LGPL-2.1 GPL-2"

DEPEND="virtual/glibc sys-devel/autoconf sys-devel/make"
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
	make DESTDIR=${D} install install-dev || die
	dosym /usr/lib/libattr.a /lib/libattr.a
	dosym /usr/lib/libattr.la /lib/libattr.la
	dosym /lib/libattr.so /usr/lib/libattr.so
}
