# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tvision/tvision-2.0.1.ebuild,v 1.2 2004/03/14 12:28:58 mr_bones_ Exp $

DESCRIPTION="Text User Interface that implements the well known CUA widgets"
HOMEPAGE="http://tvision.sourceforge.net/"
SRC_URI="mirror://sourceforge/tvision/rhtvision-${PV}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/${PN}

src_compile() {
	./configure \
		--prefix=/usr \
		--fhs \
		--no-intl \
		|| die
	make || die	# emake fails
}

src_install() {
	einstall || die
	dodoc readme.txt
	dohtml -r www-site
}
