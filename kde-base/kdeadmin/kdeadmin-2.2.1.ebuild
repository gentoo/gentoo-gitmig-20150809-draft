# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-2.2.1.ebuild,v 1.3 2001/09/29 21:03:25 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Administration"
SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV}
	>=app-arch/rpm-3.0.5
	pam? ( >=sys-libs/pam-0.72 )
 	objprelink? ( dev-util/objprelink )"

RDEPEND=$DEPEND

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.bz2

}

src_compile() {

    local myconf
    if [ "`use pam`" ]
    then
      myconf="--with-pam"
    else
      myconf="--without-pam"
    fi
    if [ "`use qtmt`" ]
    then
      myconf="$myconf --enable-mt"
    fi
	if [ "`use objprelink`" ] ; then
	  myconf="$myconf --enable-objprelink"
	fi
    ./configure --host=${CHOST} \
		--with-rpm --with-xinerama $myconf || die
    make || die
}

src_install() {
  make install DESTDIR=${D} || die
  dodoc AUTHORS COPYING README
}



