# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-2.2.1.ebuild,v 1.3 2001/09/29 12:42:18 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Games"
SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV}
 	objprelink? ( dev-util/objprelink )"

RDEPEND="$DEPEND"

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.bz2

}

src_compile() {
    
    local $myconf
    use objprelink && myconf="$myconf --enable-objprelink"
    use qtmt && myconf="$myconf --enable-mt"
    use mitshm && myconf="$myconf --enable-mitshm"
    
    ./configure --host=${CHOST} $myconf \
                 --with-xinerama || die
    make || die
}

src_install() {
  make install DESTDIR=${D} || die
  dodoc AUTHORS COPYING README
}
