# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-1.4.1.ebuild,v 1.8 2001/11/15 05:35:14 achim Exp $


S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - SDK"
SRC_PATH="kde/stable/2.1.1/distribution/tar/generic/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"
HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV} sys-devel/flex sys-devel/perl"
RDEPEND=">=kde-base/kdelibs-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
      myconf="$myconf --enable-mitshm"
    ./configure --host=${CHOST} \
		$myconf || die
    
    make LIBS=-lfl || die

}

src_install() {

  make install DESTDIR=${D} || die
  dodoc AUTHORS BUGS COPYING ChangeLog FAQ README* TODO
  docinto html
  dodoc *.html

}



