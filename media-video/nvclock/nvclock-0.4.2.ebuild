# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/nvclock/nvclock-0.4.2.ebuild,v 1.4 2002/07/11 06:30:42 drobbins Exp $

S=${WORKDIR}/${PN}${PV}
SRC_URI="http://www.evil3d.net/download/${PN}/${PN}${PV}.tar.gz"
DESCRIPTION="NVIDIA overclocking utility"
HOMEPAGE="http://www.evil3d.net/products/nvclock/"

RDEPEND="virtual/glibc gtk? ( virtual/x11 =x11-libs/gtk+-1.2* )"
DEPEND="$RDEPEND sys-devel/autoconf"

src_compile() {
	local myconf
	use gtk && myconf="--enable-gtk"
	autoconf
	touch config.h.in
	./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install	
	dodoc AUTHORS COPYING README	
}

