# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/mtools/mtools-3.9.8-r1.ebuild,v 1.12 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Mtools is a collection of utilities to access MS-DOS disks 
from Unix without mounting them. It supports Win95 style long file names,..." 
SRC_URI="http://mtools.linux.lu/mtools-3.9.8.tar.gz"
HOMEPAGE="http://mtools.linux.lu"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="sys-apps/texinfo"
RDEPEND="${DEPEND}"

src_compile() {
	econf --sysconfdir=/etc/mtools || die
	make || die
}

src_install () {
	einstall \
		sysconfdir=${D}/etc/mtools || die
	insinto /etc/mtools
	newins mtools.conf mtools.conf.example
	dodoc COPYING ChangeLog NEWPARAMS README* Release.notes 
}
