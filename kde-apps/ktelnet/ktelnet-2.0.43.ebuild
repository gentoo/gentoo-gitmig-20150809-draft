# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

A=${PN}2-0.43.tgz
S=${WORKDIR}/ktelnet2-0.43
DESCRIPTION="A Putty like for KDE"
SRC_URI="http://www.spaghetti-code.de/download/ktelnet/${A}"
HOMEPAGE="http://www.spaghetti-code.de/software/linux/ktelnet/"

DEPEND=">=kde-base/kdelibs-2.1.1"

RDEPEND=$DEPEND

src_compile() {
     local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myconf="$myconf --enable-mitshm"
    fi
    try ./configure --prefix=${KDEDIR} --host=${CHOST} $myconf
    try make

}

src_install () {
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

