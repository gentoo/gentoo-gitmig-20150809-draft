# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.3.2-r2.ebuild,v 1.4 2002/09/21 02:16:31 vapier Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Graphic ftp client written in python and gtk"
SRC_URI="mirror://sourceforge/ftpcube/${P}.tar.gz"
HOMEPAGE="http://ftpcube.sourceforge.net/"
DEPEND="<dev-python/pygtk-1.99.0"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	python setup.py clean || die "clean fails"
}

src_install() {
	dobin ftpcube
	dodir /usr/lib/python2.2/site-packages/libftpcube
	insinto /usr/lib/python2.2/site-packages/libftpcube
	doins libftpcube/*
	dodir /usr/share/ftpcube/icons
	insinto /usr/share/ftpcube/icons
	doins icons/*
	dosym /usr/share/ftpcube/icons/ftpcube.xpm /usr/share/icons
	dodoc CHANGELOG README
}
