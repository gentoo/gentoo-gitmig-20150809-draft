# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmDownload/wmDownload-0.1.2a.ebuild,v 1.14 2004/11/24 04:40:40 weeve Exp $

S=${WORKDIR}/wmDownload

IUSE=""
DESCRIPTION="dockapp that displays how much data you've received on each eth and ppp device."
SRC_URI="mirror://sourceforge/wmdownload/${P}.tar.gz"
HOMEPAGE="http://wmdownload.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc"

DEPEND="virtual/libc virtual/x11 x11-libs/docklib
	>=sys-apps/sed-4"

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
