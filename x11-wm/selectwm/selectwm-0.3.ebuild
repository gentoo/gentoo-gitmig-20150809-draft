# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: George Shapovalov <georges@its.caltech.edu>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.4 2002/03/12 16:05:09 tod Exp

S="${WORKDIR}/${P}"
DESCRIPTION="window manager selector tool"

SRC_URI="http://ordiluc.net/selectwm/${P}.tar.bz2"
HOMEPAGE="http://ordiluc.net/selectwm"

DEPEND=">=x11-libs/gtk+-1.2.0
	>=dev-libs/glib-1.2.0"

RDEPEND="${DEPEND}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	# Install documentation.
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
