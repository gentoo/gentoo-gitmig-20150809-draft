# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-frontends/sane-frontends-1.0.7.ebuild,v 1.1 2002/03/03 00:17:37 chouser Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scanner Access Now Easy"
SRC_URI="ftp://ftp.mostang.com/pub/sane/sane-${PV}/${P}.tar.gz"
HOMEPAGE="http://www.mostang.com/sane/"

DEPEND=">=media-gfx/gimp-1.2
	>=media-gfx/sane-backends-1.0.7"

src_compile() {
    ./configure \
		--prefix=/usr \
		--mandir=/usr/man \
		--datadir=/usr/share/misc \
		--host=${CHOST} || die "configure failed"
    emake || die "emake failed"
}

src_install () {
    make \
		prefix=${D}/usr \
		datadir=${D}/usr/share/misc \
		mandir=${D}/usr/man \
		install || die "make install failed"

    dodir /usr/lib/gimp/1.2/plug-ins
    dosym /usr/bin/xscanimage /usr/lib/gimp/1.2/plug-ins/xscanimage
    dodoc AUTHORS COPYING Changelog NEWS PROBLEMS README TODO
}
