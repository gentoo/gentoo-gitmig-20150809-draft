# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/noia/noia-1.0.ebuild,v 1.6 2005/07/09 23:08:24 weeve Exp $

inherit kde
need-kde 3

DESCRIPTION="Noia Icon Set for KDE"
SRC_URI="http://es.kde.org/downloads/noia-kde-icons-1.00.tgz"
HOMEPAGE="http://www.carlitus.net"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"

# stripping hangs and we've no binaries
RESTRICT="$RESTRICT nostrip"

src_unpack() {
	unpack noia-kde-icons-1.00.tgz
	mv "noia_kde_100" "${P}"
}

src_compile() {
	return 1
}

src_install(){
	dodir $PREFIX/share/icons/
	cp -r ${S} ${D}/${PREFIX}/share/icons/
}
