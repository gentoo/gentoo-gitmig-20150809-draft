# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/multitail/multitail-2.9.1.ebuild,v 1.1 2003/07/22 20:27:47 avenj Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tail with multiple windows."
HOMEPAGE="http://www.vanheusden.com/multitail/index.html"
KEYWORDS="~x86"
SRC_URI="http://www.vanheusden.com/multitail/${P}.tgz" 
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND=""

src_compile() {
	make all || die
}

src_install () {
	dobin multitail
	dodoc INSTALL license.txt readme.txt
	doman multitail.1
}
