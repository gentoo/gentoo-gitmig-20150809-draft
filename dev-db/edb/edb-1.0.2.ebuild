# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-db/edb/edb-1.0.2.ebuild,v 1.2 2001/06/24 02:20:30 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Enlightment Data Base"
SRC_URI="http://prdownloads.sourceforge.net/enlightenment/${A}"
HOMEPAGE="http://enlightenment.org"

RDEPEND="virtual/glibc x11-libs/gtk+"
DEPEND="$RDEPEND sys-apps/which"

src_compile() {

    try ./configure --prefix=/usr --enable-compat185 --enable-dump185 \
	--enable-cxx --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install

}

