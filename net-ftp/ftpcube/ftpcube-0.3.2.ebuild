# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.3.2.ebuild,v 1.2 2002/06/16 23:53:35 bass Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Graphic ftp client written in python and gtk"
SRC_URI="mirror://sourceforge/ftpcube/${P}.tar.gz"
HOMEPAGE="ftpcube.sf.net"
LICENSE="Artistic"
DEPEND="dev-python/pygtk"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"
	patch setup.cfg < ${FILESDIR}/setup.cfg.patch || die "patch failed"
}

src_compile() {
	python setup.py clean || die "clean fails"
	python setup.py build || die "build failled"
}

src_install() {
	python setup.py install || die "install failled"
	dosym /usr/share/ftpcube/icons/ftpcube.xpm /usr/share/icons
	dodoc CHANGELOG COPYING PKG-INFO README
}
