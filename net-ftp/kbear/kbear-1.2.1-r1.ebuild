# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-1.2.1-r1.ebuild,v 1.5 2001/09/29 21:03:26 danarmak Exp $


A=${P}.src.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="An FTP Manager "
SRC_URI="http://download.sourceforge.net/kbear/${A}"
HOMEPAGE="http://kbear.sourceforge.net"

DEPEND="kde-base/kde-env
	>=kde-base/kdelibs-2.1.1"

RDEPEND=$DEPEND

src_compile() {
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
      myconf="$myconf --enable-mitshm"
    try ./configure --prefix=${KDEDIR} --host=${CHOST} $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

