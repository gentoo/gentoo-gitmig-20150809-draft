# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Kuickshow image loader for kde2"
SRC_URI="http://master.kde.org/~pfeiffer/kuickshow/${A}"
HOMEPAGE="http://master.kde.org/~pfeiffer/kuickshow/"

DEPEND=">=kde-base/kdelibs-2.1.1
	>=media-libs/imlib-1.9.10"

RDEPEND=$DEPEND

src_compile() {

    try ./configure --prefix=${KDEDIR} --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

