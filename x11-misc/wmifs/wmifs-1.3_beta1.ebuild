# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmifs/wmifs-1.3_beta1.ebuild,v 1.4 2002/08/14 23:44:15 murphy Exp $

S=${WORKDIR}/wmifs.app/wmifs

DESCRIPTION="Network monitoring dock.app"
SRC_URI="http://linux.tucows.tierra.net/files/x11/dock/wmifs-1.3b1.tar.gz"
HOMEPAGE="http://www.linux.tucows.com"
DEPEND="virtual/glibc x11-base/xfree"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	emake || die
}

src_install () {
	dobin wmifs
	insinto /usr/share/wmifs
	doins sample.wmifsrc
	cd ..
	dodoc BUGS  CHANGES  COPYING  HINTS  INSTALL  README  TODO
}
