# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/imcom/imcom-0.95.ebuild,v 1.4 2003/09/05 23:58:58 msterret Exp $

S=${WORKDIR}/${P}
SRC_URI="http://imcom.floobin.cx/files/${P}.tar.gz"
HOMEPAGE="http://imcom.floobin.cx"
DESCRIPTION="Python commandline Jabber Client"

DEPEND=">=dev-lang/python-2.2
	>=dev-python/pyxml-0.7"
RDEPEND=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"
IUSE=""

src_install() {

	dodir /usr/bin
	dodir /usr/share/imcom
	dodoc AutoStatus.API CONTRIBUTORS LICENSE README* TODO WHATSNEW
	dodoc docs/*
	cp *.py ${D}/usr/share/imcom
	mv imcom imcom.orig
	sed -e 's:/usr/local/share:/usr/share:' imcom.orig | cat > imcom
	chmod 755 imcom
	dobin imcom

}
