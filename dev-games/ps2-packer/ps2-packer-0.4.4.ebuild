# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ps2-packer/ps2-packer-0.4.4.ebuild,v 1.1 2005/04/18 06:53:12 vapier Exp $

DESCRIPTION="another ELF packer for the PS2"
HOMEPAGE="http://ps2dev.org/kb.x?T=1061"
SRC_URI="http://ps2dev.org/files/${P}-linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

DEPEND="sys-libs/glibc"

S=${WORKDIR}

src_install() {
	rm -f COPYING
	insinto /opt/${PN}
	doins -r README.txt stub || die "doins"
	exeinto /opt/${PN}
	doexe *.so ps2-packer || die "doexe"

	dodir /opt/bin
	dosym /opt/{${PN},bin}/ps2-packer
}
