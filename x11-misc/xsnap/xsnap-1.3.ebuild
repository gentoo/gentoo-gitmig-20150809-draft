# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsnap/xsnap-1.3.ebuild,v 1.2 2004/02/12 03:55:05 weeve Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Program to interactively take a 'snapshot' of a region of
the screen"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/Xutils/${P}.tgz"
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/Xutils/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc ~sparc"

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man || die
	dodoc README INSTALL AUTHORS
}
