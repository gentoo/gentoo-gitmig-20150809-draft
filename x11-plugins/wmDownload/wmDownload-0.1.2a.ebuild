# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmDownload/wmDownload-0.1.2a.ebuild,v 1.1 2002/10/03 17:53:09 raker Exp $

S=${WORKDIR}/wmDownload

DESCRIPTION="dockapp that displays how much data you've recieved on each eth and ppp device."
SRC_URI="mirror://sourceforge/wmdownload/${P}.tar.gz"
HOMEPAGE="http://wmdownload.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORKS="x86"

DEPEND="virtual/glibc x11-base/xfree x11-libs/docklib"
RDEPEND="${DEPEND}"

src_compile() {

	cd ${S}

	cp Makefile Makefile.orig
	sed -e "s:-O2:$CFLAGS:" Makefile.orig > Makefile

	emake || die 

}

src_install () {

	strip wmDownload
	dodir /usr/bin/
        dobin wmDownload

}
