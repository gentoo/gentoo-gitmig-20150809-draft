# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmips-cross-bin/vmips-cross-bin-1.0.ebuild,v 1.3 2004/10/20 20:56:36 dholm Exp $

SRC_URI="ppc? ( mirror://gentoo/${P}.ppc.tar.bz2 )"
DESCRIPTION="vmips cross-development tools"
HOMEPAGE="http://vmips.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc"
DEPEND=""
IUSE=""

src_install() {
	mkdir -p ${D}/opt
	mv ${WORKDIR}/mips ${D}/opt
}
