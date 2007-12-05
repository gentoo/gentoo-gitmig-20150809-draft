# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/geekcredit/geekcredit-0.019.ebuild,v 1.4 2007/12/05 12:54:26 coldwind Exp $

inherit python

MY_P=${P/geekcredit/gc}
IUSE=""
DESCRIPTION="Digital complementary currency for internet."
SRC_URI="http://download.gna.org/geekcredit/${MY_P}.tgz"
HOMEPAGE="http://home.gna.org/geekcredit/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
DEPEND="virtual/python
		app-crypt/gnupg"

S=${WORKDIR}/${MY_P}

src_compile() {
	einfo "There is nothing to compile."
}

src_install() {
	python_version
	dobin GCPocket.py
	dodoc *.txt
	cp test.sh "${D}"/usr/share/doc/${P}/
	insinto /usr/lib/python${PYVER}/site-packages/
	doins GeekCredit.py
	insinto /etc
	doins gc.cfg
}

pkg_postinst() {
	elog
	elog "Look at /usr/share/doc/${P}/test.sh for examples of most commands."
	elog
}
