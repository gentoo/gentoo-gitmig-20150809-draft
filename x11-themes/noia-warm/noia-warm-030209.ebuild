# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/noia-warm/noia-warm-030209.ebuild,v 1.10 2004/07/03 20:14:57 carlo Exp $

inherit kde

S="${WORKDIR}/noia-warm"

DESCRIPTION="Noia Icon Set for KDE"
HOMEPAGE="http://www.carlitus.net"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc amd64"
IUSE=""

# stripping hangs and we've no binaries
RESTRICT="nostrip"

DEPEND=">=sys-apps/sed-4"
need-kde 3

src_unpack() {
	unpack ${P}.tar.gz
}

src_compile() {
	cd ${WORKDIR}
	mv "Noia Warm KDE 0.95" "noia-warm"
	cd ${S}
	sed -i "s/Name=Noia Warm KDE.*/Name=Noia Warm Icon Snapshot ${PV}/" index.desktop
	return 1
}

src_install(){
	cd ${S}
	dodir $PREFIX/share/icons/
	cp -rf ${S} ${D}/${PREFIX}/share/icons/Noia-Warm-${PV}
}
