# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Michael M Nazaroff <naz@themoonsofjupiter.net>
#/home/cvsroot/gentoo-x86/media-sound/qtella/qtella-0.2.1.ebuild, v 1 2001/09/04 pm 

S=${WORKDIR}/${P}
DESCRIPTION="Gnutella Client based on Qt"
SRC_PATH="qtella/${P}.tar.gz"
SRC_URI="http://prdownloads.sourceforge.net/$SRC_PATH
	 http://www.research.att.com/~leonb/objprelink/kde-admin-acinclude.patch"

HOMEPAGE="http://qtella.sourceforge.net"

DEPEND=">=kde-base/kdebase-${PV}"

RDEPEND=$DEPEND

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.gz
}

src_compile() {
    . /etc/env.d/90{kde${PV},qt}
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
      myconf="$myconf --enable-mitshm"
    ./configure --host=${CHOST} \
                --with-xinerama $myconf || die
    make || die
}

src_install() {
  make install DESTDIR=${D} || die
  dodoc AUTHORS COPYING README
}
