# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/x11-misc/epplet-base/epplet-base-0.5.ebuild,v 1.2 2002/04/27 23:34:21 bangert Exp

S="${WORKDIR}/Epplets-${PV}"

DESCRIPTION="Base files for Enlightenment epplets and some epplets"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"

HOMEPAGE="http://sourceforge.net/projects/enlightenment"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=x11-base/xfree-4.2.0
	>=media-libs/imlib-1.9.10
	>=x11-wm/enlightenment-0.16.5-r4"

src_compile() {
	EBIN=/usr/bin \
	EROOT=/usr/share/enlightenment \
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog
}
