# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: tools@cvs.gentoo.org
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.1.1-r1.ebuild,v 1.1 2001/08/16 04:20:33 chadh Exp $

S=${WORKDIR}/Python-${PV}
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/2.1.1/Python-${PV}.tgz"

HOMEPAGE="http://www.python.org"
DEPEND="virtual/glibc >=sys-libs/zlib-1.1.3
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )
	berkdb? ( >=sys-libs/db-3 )"

RDEPEND="$DEPEND"
PROVIDE="virtual/python"

src_compile() {   
    cd ${S}
    try ./configure --prefix=/usr --without-libdb --infodir=/usr/share/info --mandir=/usr/share/man
	#libdb3 support is available from http://pybsddb.sourceforge.net/; the one
	#included with python is for db 1.85 only.
    # Parallel make does not work
    try make 
}

src_install() {                 
    dodir /usr            
    try make install prefix=${D}/usr
	rm ${D}/usr/bin/python
	dosym python2.1 /usr/bin/python
#    mv ${D}/bin/python1.5 ${D}/bin/spython1.5
   # for i in lib-dynload lib-stdwin lib-tk test
   # do
   #     rm -r ${D}/lib/python1.5/${i}
   # done
   # rm -r ${D}/include 
    dodoc README
}
