# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

A=${P}.src.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="An FTP Manager "
SRC_URI="http://download.sourceforge.net/kbear/${A}"
HOMEPAGE="http://kbear.sourceforge.net"

DEPEND="kde-base/kde-env
	>=kde-base/kdelibs-2.1.1"

RDEPEND=$DEPEND

src_compile() {

    try ./configure --prefix=${KDEDIR} --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

