# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gensink/gensink-4.1.ebuild,v 1.2 2003/07/13 11:30:11 aliz Exp $

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
