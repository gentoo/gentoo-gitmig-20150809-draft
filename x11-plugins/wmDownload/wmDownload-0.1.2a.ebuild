# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmDownload/wmDownload-0.1.2a.ebuild,v 1.7 2004/01/04 18:36:48 aliz Exp $

S=${WORKDIR}/wmDownload

DESCRIPTION="dockapp that displays how much data you've recieved on each eth and ppp device."
SRC_URI="mirror://sourceforge/wmdownload/${P}.tar.gz"
HOMEPAGE="http://wmdownload.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/glibc x11-base/xfree x11-libs/docklib"

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i -e "s:-O2:$CFLAGS:" Makefile
}

src_compile() {
	emake || die
}

src_install () {
	strip wmDownload
	dodir /usr/bin/
	dobin wmDownload
}
