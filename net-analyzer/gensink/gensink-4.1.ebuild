# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gensink/gensink-4.1.ebuild,v 1.3 2004/06/24 22:02:22 agriffis Exp $

DESCRIPTION="Gensink ${PV}, a simple TCP benchmark suite."
HOMEPAGE="http://jes.home.cern.ch/jes/gensink/"
SRC_URI="http://jes.home.cern.ch/jes/gensink/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha"
IUSE=""
DEPEND=""
S=${WORKDIR}/${P}

src_compile() {
	make || die
}

src_install() {
	dodoc COPYING
	exeinto /usr/bin
	doexe sink4 tub4 gen4
}
