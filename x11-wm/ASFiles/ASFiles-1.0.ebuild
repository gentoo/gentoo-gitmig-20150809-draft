# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ASFiles/ASFiles-1.0.ebuild,v 1.1 2001/09/27 21:56:51 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="NeXTish filemanager, hacked from OffiX"

SRC_URI="http://www.tigr.net/afterstep/download/ASFiles/ASFiles-1.0.tar.gz"

HOMEPAGE="http://www.tigr.net/afterstep/list.pl"

DEPEND=">=x11-wm/afterstep-1.8.8
        >=x11-libs/dnd-1.1"

src_unpack() {

    unpack ASFiles-1.0.tar.gz
    cd ${S}
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}
src_compile() {

    ./configure --infodir=/usr/share/info \
                --mandir=/usr/share/man \
                --prefix=/usr \
                --with-x \
                --with-dnd-inc=/usr/include/OffiX \
                --with-dnd-lib=/usr/lib \
                --host=${CHOST} || die
    emake || die
}

src_install () {

    make prefix=${D}/usr install || die

#    make DESTDIR=${D} install || die
}

