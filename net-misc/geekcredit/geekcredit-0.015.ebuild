# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/geekcredit/geekcredit-0.015.ebuild,v 1.3 2004/04/09 16:00:52 zul Exp $

inherit python

MY_P=${P/geekcredit/gc}
IUSE=""
DESCRIPTION="Rawdog - RSS Aggregator Without Delusions Of Grandeur"
SRC_URI="http://download.gna.org/geekcredit/${MY_P}.tgz"
HOMEPAGE="http://www.geekcredit.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DEPEND="virtual/python
		app-crypt/gnupg"
RDEPEND=${DEPEND}

S=${WORKDIR}/${MY_P}

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
