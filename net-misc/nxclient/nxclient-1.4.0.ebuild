# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

DESCRIPTION="NXClient is a X11/VNC/NXServer client especially tuned for using remote desktops over low-bandwidth links such as the Internet"
HOMEPAGE="http://www.nomachine.com"

IUSE=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc -alpha -mips"
RESTRICT="nostrip"

MY_PV="${PV}-14"
SRC_URI="http://www.nomachine.com/download/snapshot/nxbinaries/Linux/nxclient-${MY_PV}.i386.tar.gz"

DEPEND=""

S="${WORKDIR}/NX"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/NX
	cp -R * ${D}/usr/NX

	insinto /etc/env.d
	doins ${FILESDIR}/1.3.0/50nxclient
}
