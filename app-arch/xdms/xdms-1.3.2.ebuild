# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/xdms/xdms-1.3.2.ebuild,v 1.2 2007/03/20 21:21:10 armin76 Exp $

inherit eutils

DESCRIPTION="xDMS - Amiga DMS disk image decompressor"
HOMEPAGE="http://zakalwe.fi/~shd/foss/xdms/"
SRC_URI="http://zakalwe.fi/~shd/foss/xdms/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc x86"
IUSE=""

src_compile() {
	cd ${S}
	./configure --prefix=/usr --package-prefix="${D}" \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make install || die "make install failed"
	dodoc COPYING xdms.txt ChangeLog.txt
}
