# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mowitz/mowitz-0.2.1.ebuild,v 1.9 2003/04/01 22:30:42 spider Exp $

S=${WORKDIR}/Mowitz-${PV}
SRC_URI="http://siag.nu/pub/mowitz/Mowitz-${PV}.tar.gz"
HOMEPAGE="http://siag.nu/mowitz/"
DESCRIPTION="Mowitz - more widgets library"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/x11"
	#>=media-libs/t1lib-1.0.1"

src_compile() {

	econf --with-xawm=Xaw || die "Configure broke"
#		    --with-t1lib \

	emake || die "Make broke"
}

src_install() {
	make DESTDIR=${D} install
}
