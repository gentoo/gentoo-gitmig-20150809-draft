# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kdoc/kdoc-2.1.1.ebuild,v 1.2 2001/06/07 21:10:33 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Documentation"
SRC_PATH="kde/stable/2.1.1/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org"

DEPEND=">=sys-devel/perl-5 kde-base/kde-env"

src_compile() {

    try ./configure --prefix=${KDEDIR} --host=${CHOST}
    try make
}

src_install() {

  try make install DESTDIR=${D}
  dodoc README TODO Version

}









