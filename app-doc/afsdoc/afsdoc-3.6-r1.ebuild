# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-doc/afsdoc/afsdoc-3.6-r1.ebuild,v 1.7 2002/08/01 14:02:43 seemant Exp $


S=${WORKDIR}/${P}
DESCRIPTION="The AFS 3 distributed file system	targets the issues	critical to
distributed computing environments. AFS performs exceptionally well,
both within small, local work groups of machines and across wide-area
configurations in support of large, collaborative efforts. AFS provides
an architecture geared towards system management, along with the tools
to perform important management tasks. For a user, AFS is a familiar yet
extensive UNIX environment for accessing files easily and quickly."
SRC_URI="http://www.openafs.org/dl/openafs/1.0.3/afs-3.6-doc.tar.gz"
HOMEPAGE="http://www.openafs.org/"

SLOT="0"
LICENSE="IPL-1"
KEYWORDS="x86 ppc sparc sparc64"

src_install () {
	dodir /usr/share/doc 
	tar -zxf ${DISTDIR}/${A} -C ${D}/usr/share/doc 
	cd ${D}/usr/share/doc
	mv afs-3.6-doc ${PF}
	cd ${PF}
	mv PDF print
	prepalldocs
}
