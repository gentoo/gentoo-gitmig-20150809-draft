# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tvision/tvision-2.0.3.ebuild,v 1.3 2005/01/11 19:21:40 luckyduck Exp $

DESCRIPTION="Text User Interface that implements the well known CUA widgets"
HOMEPAGE="http://tvision.sourceforge.net/"
SRC_URI="mirror://sourceforge/tvision/rhtvision-${PV}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

S=${WORKDIR}/${PN}

src_compile() {
	./configure \
		--prefix=/usr \
		--fhs \
		--no-intl \
		|| die
	emake || die
}

src_install() {
	einstall || die
	dosym rhtvision /usr/include/tvision
	dodoc readme.txt THANKS TODO
	dohtml -r www-site
}
