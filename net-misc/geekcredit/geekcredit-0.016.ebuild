# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/geekcredit/geekcredit-0.016.ebuild,v 1.6 2004/07/21 20:38:09 mr_bones_ Exp $

inherit python

MY_P=${P/geekcredit/gc}
DESCRIPTION="Digital complementary currency for internet."
HOMEPAGE="http://www.geekcredit.org/"
SRC_URI="http://download.gna.org/geekcredit/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/python
		app-crypt/gnupg"

S="${WORKDIR}/${MY_P}"

src_compile() {
	einfo "There is nothing to compile."
}

src_install() {
	python_version
	dobin GCPocket.py
	dodoc *.txt
	cp test.sh ${D}/usr/share/doc/${P}/
	insinto /usr/lib/python${PYVER}/site-packages/
	doins GeekCredit.py
	insinto /etc
	doins gc.cfg
}

pkg_postinst() {
	einfo
	einfo "Look at /usr/share/doc/${P}/test.sh for examples of most commands."
	einfo
}
