# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xfsprogs/xfsprogs-20020330-r1.ebuild,v 1.3 2002/08/14 04:44:36 murphy Exp $

S=${WORKDIR}/cmd/${PN}
DESCRIPTION="xfs filesystem utilities"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/xfs-cmd-${PV}.tar.bz2"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="LGPL-2.1"
oldCFLAGS="${CFLAGS}"
oldCXXFLAGS="${CXXFLAGS}"

DEPEND="virtual/glibc sys-devel/autoconf sys-devel/make sys-apps/e2fsprogs"
RDEPEND="virtual/glibc"

ebuild_die() {
	export CFLAGS="${oldCFLAGS}"
	export CXXFLAGS="${oldCXXFLAGS}"
	if([ -n "$LINE" ]) then 
		die "Line ${2}: ${1}"
	else
		die "${1}"
	fi
}


src_compile() {
	cd ${S}
	export CFLAGS="`echo ${CFLAGS} | sed "s/ -O[2-9]/ -O1/g"`"
	export CXXFLAGS="`echo ${CXXFLAGS} | sed "s/ -O[2-9]/ -O1/g"`"
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
	include/builddefs.orig > include/builddefs || ebuild_die "sed failed" 49
	emake || ebuild_die "emake failed" 50
	export ${oldCFLAGS}
	export ${oldCXXFLAGS}
}

src_install() {
	make DESTDIR=${D} DK_INC_DIR=${D}/usr/include/disk install install-dev || ebuild_die "make install failed" 54
	cat ${S}/libhandle/.libs/libhandle.la | sed -e 's:installed=no:installed=yes:g' > ${D}/usr/lib/libhandle.la
	dodir /usr/lib /lib
	insinto /usr/lib
	doins libhandle.a
	exeinto /lib
	doins libhandle.so.1.0.0
	cd ${D}/lib
	ln -sf ../usr/lib/libhandle.a libhandle.a
	ln -sf libhandle.so.1.0.0 libhandle.so.1
	ln -sf libhandle.so.1 libhandle.so
	cd ${D}/usr/lib
	ln -sf ../../lib/libhandle.so libhandle.so
}
