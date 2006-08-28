# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tvision/tvision-2.1.0_pre1.ebuild,v 1.1 2006/08/28 14:14:01 truedfx Exp $

inherit eutils

DESCRIPTION="Text User Interface that implements the well known CUA widgets"
HOMEPAGE="http://tvision.sourceforge.net/"
SRC_URI="mirror://sourceforge/tvision/rhtvision_${PV/_pre/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	./configure \
		--prefix=/usr \
		--fhs \
		|| die
	emake || die
}

src_install() {
	einstall || die
	dosym rhtvision /usr/include/tvision
	dodoc readme.txt THANKS TODO
	dohtml -r www-site
}
