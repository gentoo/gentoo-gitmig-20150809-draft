# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/noia-warm/noia-warm-030209.ebuild,v 1.3 2003/09/01 06:54:11 lu_zero Exp $
inherit kde # not kde-base since we don't need c++ deps

need-kde 3

S="${WORKDIR}/noia-warm"
DESCRIPTION="Noia Icon Set for KDE"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="http://www.carlitus.net"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="as-is"

# stripping hangs and we've no binaries
RESTRICT="$RESTRICT nostrip"

src_unpack() {
	unpack ${P}.tar.gz
}

src_compile() {
	cd ${WORKDIR}
	mv "Noia Warm KDE 0.95" "noia-warm"
	cd ${S}
	sed "s/Name=Noia Warm KDE.*/Name=Noia Warm Icon Snapshot ${PV}/" index.desktop > index.temp
	mv index.temp index.desktop
	return 1
}

src_install(){
	cd ${S}
	dodir $PREFIX/share/icons/
	cp -rf ${S} ${D}/${PREFIX}/share/icons/Noia-Warm-${PV}
}
