# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/noia/noia-1.0.ebuild,v 1.2 2004/06/24 23:36:15 agriffis Exp $
inherit kde # not kde-base since we don't need c++ deps

need-kde 3

DESCRIPTION="Noia Icon Set for KDE"
SRC_URI="http://es.kde.org/downloads/noia-kde-icons-1.00.tgz"
HOMEPAGE="http://www.carlitus.net"
KEYWORDS="x86 ppc"
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
