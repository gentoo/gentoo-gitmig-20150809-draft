# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmifs/wmifs-1.3_beta1.ebuild,v 1.6 2004/02/17 07:49:52 mr_bones_ Exp $

S=${WORKDIR}/wmifs.app/wmifs
DESCRIPTION="Network monitoring dock.app"
SRC_URI="http://linux.tucows.tierra.net/files/x11/dock/wmifs-1.3b1.tar.gz"
HOMEPAGE="http://www.linux.tucows.com"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"

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
