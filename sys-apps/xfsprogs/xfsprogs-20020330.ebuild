# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xfsprogs/xfsprogs-20020330.ebuild,v 1.5 2002/03/31 04:51:27 drobbins Exp $

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
	# 1) add a ${DESTDIR} prefix to all install paths so we can relocate during the "install" phase
	# 2) we also set the /usr/share/doc/ directory to the correct value.
	# 3) we remove a hard-coded "-O1"
	# 4) we fix some Makefile-created library symlinks that contains absolute paths
	cp include/builddefs include/builddefs.orig
	sed -e "s:/usr/share/doc/${PN}:/usr/share/doc/${PF}:" \
	-e 's:-O1::' \
	-e '/-S $(PKG/d' \
	-e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
	include/builddefs.orig > include/builddefs || die
	emake || die
}

src_install() {
	make DESTDIR=${D} DK_INC_DIR=${D}/usr/include/disk install install-dev || die
	cat ${S}/libhandle/.libs/libhandle.la | sed -e 's:installed=no:installed=yes:g' > ${D}/usr/lib/libhandle.la
	cd ${D}/lib
	ln -s ../usr/lib/libhandle.a libhandle.a
	ln -s libhandle.so.1 libhandle.so.1.0.0
	ln -s libhandle.so libhandle.so.1
	cd ${D}/usr/lib
	ln -s ../../lib/libhandle.so libhandle.so
}
