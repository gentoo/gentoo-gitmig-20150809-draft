# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox/busybox-0.50.ebuild,v 1.1 2001/04/08 17:11:53 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Utilities for rescue and embedded systems"
SRC_URI="ftp://oss.lineo.com/busybox/${A}"
HOMEPAGE="http://busybox.lineo.com/"


src_compile() {

    cd ${S}
    export OPT="`echo $CFLAGS|sed 's:.*\(-O.\).*:\1:'`"
    export CFLAGS_EXTRA=${CFLAGS/-O?/}
    unset CFLAGS
    echo $CFLAGS_EXTRA $OPT
    try make CFLAGS_EXTRA=\"${CFLAGS_EXTRA}\" OPTIMIZATION=$OPT

}

src_install () {

    cd ${S}
    dobin busybox
    dodoc AUTHORS Changelog LICENSE README TODO
    cd docs
    doman *.1
    docinto txt
    dodoc *.txt
    docinto sgml
    dodoc *.sgml
    docinto pod
    dodoc *.pod

    cd busybox.lineo.com
    docinto html
    dodoc *.html
    docinto html/images
    dodoc images/*


}

