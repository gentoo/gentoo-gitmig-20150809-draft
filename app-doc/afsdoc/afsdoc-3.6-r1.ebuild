# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/afsdoc/afsdoc-3.6-r1.ebuild,v 1.12 2003/09/06 22:17:40 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="AFS 3 distributed file system"
SRC_URI="http://www.openafs.org/dl/openafs/1.0.3/afs-3.6-doc.tar.gz"
HOMEPAGE="http://www.openafs.org/"

SLOT="0"
LICENSE="IPL-1"
KEYWORDS="x86 ppc sparc "

DEPEND="sys-apps/tar sys-apps/gzip"
RDEPEND=""

src_install() {
	dodir /usr/share/doc
	tar -zxf ${DISTDIR}/${A} -C ${D}/usr/share/doc
	cd ${D}/usr/share/doc
	mv afs-3.6-doc ${PF}
	cd ${PF}
	mv PDF print
	prepalldocs
}
