# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/sgml-common/sgml-common-0.6.1.ebuild,v 1.1 2001/03/06 06:20:41 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Base ISO character entities and utilities for SGML"
SRC_URI="ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/${A}
	 http://download.sourceforge.net/pub/mirrors/kde/devel/docbook/SOURCES/${A}"
HOMEPAGE="http://www.iso.ch/cate/3524030.html"

DEPEND=">=sys-apps/bash-2.04"

src_compile() {

  try ./configure --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man
  try make
}
src_install () {

    cd ${S}
    try make prefix=${D}/usr sysconfdir=${D}/etc mandir=${D}/usr/share/man \
        docdir=${D}/usr/share/doc install

}

