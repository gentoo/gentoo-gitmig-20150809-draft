# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/imcom/imcom-1.33.ebuild,v 1.8 2005/04/02 02:29:08 weeve Exp $

SRC_URI="http://imcom.floobin.cx/files/${P}.tar.gz"
#SRC_URI="http://nafai.dyndns.org/files/imcom-betas/${PN}-${MYVER}.tar.gz"
HOMEPAGE="http://imcom.floobin.cx"
DESCRIPTION="Python commandline Jabber Client"

DEPEND=">=dev-lang/python-2.2
	>=dev-python/pyxml-0.7"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc sparc ~amd64"
IUSE=""

src_compile() {
	./configure --prefix=/usr || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	dodoc CONTRIBUTORS LICENSE README* TODO WHATSNEW docs/CHANGELOG
	dohtml docs/*.html docs/*.png docs/*.jpg docs/*.css
	doman docs/imcom.1
	make prefix=${D}/usr install-bin
}
