# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Kuickshow image loader for kde2"
SRC_URI="http://master.kde.org/~pfeiffer/kuickshow/${A}"
HOMEPAGE="http://master.kde.org/~pfeiffer/kuickshow/"

DEPEND=">=kde-base/kdelibs-2.0"

RDEPEND=$DEPEND

src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/kde2.1 --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

