# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tvision/tvision-2.0.2.ebuild,v 1.1 2004/07/24 05:31:27 vapier Exp $

DESCRIPTION="Text User Interface that implements the well known CUA widgets"
HOMEPAGE="http://tvision.sourceforge.net/"
SRC_URI="mirror://sourceforge/tvision/rhtvision-${PV}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

S=${WORKDIR}/${PN}

src_compile() {
	./configure \
		--prefix=/usr \
		--fhs \
		--no-intl \
		|| die
	emake || die	# emake fails
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc readme.txt THANKS TODO
	dohtml -r www-site
}
