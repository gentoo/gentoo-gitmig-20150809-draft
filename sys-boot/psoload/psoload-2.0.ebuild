# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/psoload/psoload-2.0.ebuild,v 1.1 2004/11/15 00:31:43 vapier Exp $

DESCRIPTION="Load home brewed code onto the GameCube with Phantasy Star Online"
HOMEPAGE="http://www.gc-linux.org/"
SRC_URI="http://www.gcdev.com/download/PSOloadV${PV}_Linux.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_install() {
	into /opt
	dobin psoload2 psoload2_static || die "dobin"
	dodoc *.txt testdemo4.dol crt0.s
}
