# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kdoc/kdoc-2.2.ebuild,v 1.1 2001/10/28 10:23:28 achim Exp $

V=2.2
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE ${V} - Documentation"
SRC_PATH="kde/stable/${V}/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
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









