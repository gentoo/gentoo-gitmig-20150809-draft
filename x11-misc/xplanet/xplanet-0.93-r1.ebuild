# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xplanet/xplanet-0.93-r1.ebuild,v 1.10 2003/09/05 23:18:18 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A program to render images of the earth into the X root window"
SRC_URI="mirror://sourceforge/xplanet/${P}.tar.gz"
HOMEPAGE="http://xplanet.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11"

src_compile() {
	local myconf
	use opengl \
		&& myconf="--with-gl --with-glut --with-animation" \
		|| myconf="--with-gl=no --with-glut=no --with-animation=no"

	use gif \
		&& myconf="${myconf} --with-gif" \
		|| myconf="${myconf} --with-gif=no"

	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --with-x=no"

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--with-freetype=no \
		${myconf} || die
	# xplanet doesn't like to build parallel
	# This fix taken from the gimp ebuild
	make || die
}

src_install () {
	make prefix=${D}/usr mandir=${D}/usr/share/man install || die
}
