# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.4.0.ebuild,v 1.4 2004/04/27 21:49:05 agriffis Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Graphic ftp client written in python and gtk"
SRC_URI="mirror://sourceforge/ftpcube/${P}.tar.gz"
HOMEPAGE="http://ftpcube.sourceforge.net/"
DEPEND="dev-python/wxPython"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~sparc"

src_compile() {
	python setup.py clean || die "clean fails"
}

src_install() {
	dobin ftpcube
	dodir /usr/lib/python2.2/site-packages/libftpcube
	dodir /usr/lib/python2.2/site-packages/libftpcube/archtypes
	dodir /usr/lib/python2.2/site-packages/libftpcube/wxPyColourChooser
	insinto /usr/lib/python2.2/site-packages/libftpcube
	doins libftpcube/*
	insinto /usr/lib/python2.2/site-packages/libftpcube/archtypes
	doins libftpcube/archtypes/*
	insinto /usr/lib/python2.2/site-packages/libftpcube/wxPyColourChooser
	doins libftpcube/wxPyColourChooser/*
	dodir /usr/share/ftpcube/icons
	insinto /usr/share/ftpcube/icons
	doins icons/*
	dosym /usr/share/ftpcube/icons/ftpcube.xpm /usr/share/icons
	dodoc CHANGELOG README TODO COPYING COPYING.ICONS
}
