# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/afsdoc/afsdoc-3.6-r1.ebuild,v 1.14 2004/03/14 00:14:29 mr_bones_ Exp $

DESCRIPTION="AFS 3 distributed file system"
SRC_URI="http://www.openafs.org/dl/openafs/1.0.3/afs-3.6-doc.tar.gz"
HOMEPAGE="http://www.openafs.org/"

SLOT="0"
LICENSE="IPL-1"
KEYWORDS="x86 ppc sparc"

DEPEND=""

src_install() {
	dodir /usr/share/doc
	mv ${WORKDIR}/afs-3.6-doc ${D}/usr/share/doc
}
