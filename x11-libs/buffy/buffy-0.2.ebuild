# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/buffy/buffy-0.2.ebuild,v 1.1 2001/08/13 00:56:30 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="GTK+ theme engine"

SRC_URI="http://reality.sgi.com/offer/src/buffy/${P}.tar.gz"

HOMEPAGE="http://reality.sgi.com/offer/src/buffy/"

DEPEND="virtual/glibc 
        >=x11-libs/gtk+-1.2.10"

src_compile() {

    try ./configure --infodir=/usr/info \
                    --mandir=/usr/X11R6/man \
                    --prefix=/usr/X11R6 \
                    --host=${CHOST}
    try emake
}

src_install () {

    # try make prefix=${D}/usr install

    dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
    try make DESTDIR=${D} install
}

