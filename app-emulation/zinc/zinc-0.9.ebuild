# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/zinc/zinc-0.9.ebuild,v 1.2 2002/08/06 18:37:20 gerk Exp $

S="${WORKDIR}/zinc"
A="${P}-linux.tar.bz2"
DESCRIPTION="ZiNc is an x86 binary-only emulator for the Sony ZN-1, ZN-2, and Namco System 11 arcade systems."
SRC_URI="http://www.emuhype.com/files/${A}"
HOMEPAGE="http://www.emuhype.com"
DEPEND="=sys-apps/baselayout-1.8.0"
RDEPEND="${DEPEND}"
KEYWORDS="x86 -ppc -sparc -sparc64"
LICENSE="proprietary"
SLOT="0"

src_unpack() {
	if [ ${ARCH} != "x86" ]; then
		echo "Binary-only x86 package" && die
	fi
	unpack ${A}
	cd ${S}
}

src_install() {
	exeinto /opt/bin
	doexe zinc
	dolib.so libcontrolznc.so librendererznc.so libsoundznc.so
}

