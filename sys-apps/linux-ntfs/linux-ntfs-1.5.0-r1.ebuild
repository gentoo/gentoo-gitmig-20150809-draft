# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/linux-ntfs/linux-ntfs-1.5.0-r1.ebuild,v 1.6 2002/07/21 20:05:56 gerk Exp $

# NB: This project actually requires >=gcc.2.96!  This ebuild installs an
# rpm binary package into /opt.  Eventually we'll compile it ourselves..

DESCRIPTION="Utilities and library for accessing NTFS filesystems"
HOMEPAGE="http://linux-ntfs.sourceforge.net/"
KEYWORDS="x86 -ppc -sparc -sparc64"
SLOT="0"
LICENSE="GPL-2"

S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}-${PR/r/}.i386.rpm
	mirror://sourceforge/${PN}/${PN}-devel-${PV}-${PR/r/}.i386.rpm"
DEPEND="virtual/glibc app-arch/rpm2targz"

src_unpack() {

	local i
	for i in ${A}
	do
		rpm2targz ${DISTDIR}/${i}
		tar zxf ${i/rpm/tar.gz}
		rm -f ${i/rpm/tar.gz}
	done
}

src_compile() { :; }
 

src_install() {

	cd ${D}
	mkdir -p opt/${PN}
	mv ${WORKDIR}/usr/* opt/${PN}
	cd opt/${PN}

	mv sbin/mkntfs bin
	rm -rf sbin

	mkdir -p ${D}/usr/share/doc ${D}/usr/include
	mv share/doc/${PN}-${PV} ${D}/usr/share/doc/${PF}
	rm -rf share/doc
	dosym /opt/${PN}/include/ntfs /usr/include/ntfs

	insinto /etc/env.d
	doins ${FILESDIR}/50ntfs
}
