# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/entity/entity-pre-0.7.0.ebuild,v 1.1 2000/11/18 12:27:44 achim Exp $

P=entity-pre0.7.0
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An XML Framework"
SRC_URI="http://entity.evilplan.org/Download/files/${A}"
HOMEPAGE="http://entity.evilplan.org"

DEPEND=">=media-libs/imlib-1.9.8.1
	>=dev-libs/libpcre-3.2
	>=dev-lang/tcl-tk-8.1.1
	>=sys-devel/perl-5.6"

RDEPEND="$DEPEND
	 sys-apps/bash"

src_compile() {

    cd ${S}
    try DEBIAN_ENTITY_MAGIC=voodoo ./configure --prefix=/usr --host=${CHOST} \
	--enable-exec-class=yes \
	--enable-gtk=module \
	--enable-perl=static --enable-python=no \
	--enable-tcl=module  --with-tcl=/usr/lib \
	--enable-c=module \
	--enable-javascript=yes --with-included-njs 
    try make

}

src_install () {

    cd ${S}
    export LD_LIBRARY_PATH=${D}/usr/lib
    try make DESTDIR=${D} install

}

