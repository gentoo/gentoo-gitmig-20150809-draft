# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/jfsutils/jfsutils-1.0.23.ebuild,v 1.1 2002/09/27 16:49:03 bcowan Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IBM's Journaling Filesystem (JFS) Utilities"
SRC_URI="http://www10.software.ibm.com/developer/opensource/jfs/project/pub/${P}.tar.gz"
HOMEPAGE="http://www-124.ibm.com/developerworks/oss/jfs/index.html"
KEYWORDS="x86 -ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_compile() {
	./configure --prefix=/usr \
		    --sbindir=/sbin \
		    --host=${CHOST} \
		    --sysconfdir=/etc \
		    --mandir=/usr/share/man || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die 
	
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}

