# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpager/wmpager-1.2-r1.ebuild,v 1.1 2003/12/26 18:03:05 port001 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A simple pager docklet for the WindowMaker window manager."
HOMEPAGE="http://wmpager.sourceforge.net/"
SRC_URI="mirror://sourceforge/wmpager/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4"

RDEPEND="virtual/x11
	virtual/glibc"

src_compile() {
	sed -i "s:\(WMPAGER_DEFAULT_INSTALL_DIR \).*:\1\"/usr/share/wmpager\":" \
		src/wmpager.c

	emake || die
}

src_install() {
	make INSTALLDIR=${D}/usr install || die

	rm -rf ${D}/usr/man
	doman man/man1/*.1x
	dodoc README
}
