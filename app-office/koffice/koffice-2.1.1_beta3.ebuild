# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-2.1.1_beta3.ebuild,v 1.3 2001/09/29 21:03:25 danarmak Exp $

P=${PN}-1.1-beta3
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - KOffice"
SRC_PATH="kde/unstable/${P}/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-2.1.2
	>=dev-lang/python-2.0-r2
	sys-devel/automake
	sys-devel/autoconf"

RDEPEND=">=kde-base/kdelibs-2.1.2"


src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${PN}-2.1.1_beta2-gentoo.diff
	make -f admin/Makefile.common
}

src_compile() {
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
      myconf="$myconf --enable-mitshm"
    try ./configure  --host=${CHOST} \
		 $myconf
   try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc ChangeLog COPYING AUTHORS NEWS README
}

