# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="A sed/awk/grep apps "
SRC_URI="http://download.sourceforge.net/kfilereplace/${A}"
HOMEPAGE="http://kfilereplace.sourceforge.net"

DEPEND=">=kde-base/kdelibs-2.1.1"

RDEPEND=$DEPEND

src_compile() {

    try ./configure --prefix=${KDEDIR} --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} kde_locale=${D}${KDEDIR}/share/locale install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

