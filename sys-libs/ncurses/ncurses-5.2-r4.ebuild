# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.2-r4.ebuild,v 1.1 2001/06/19 00:27:38 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Linux console display libarary"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/ncurses/${P}.tar.gz
         ftp://dickey.his.com/ncurses/5.2/patch-5.2-20010512.sh
	 ftp://dickey.his.com/ncurses/5.2/${P}-20010618.patch.gz
         ftp://dickey.his.com/ncurses/5.2/${P}-20010616.patch.gz
         ftp://dickey.his.com/ncurses/5.2/${P}-20010609.patch.gz
         ftp://dickey.his.com/ncurses/5.2/${P}-20010603.patch.gz
         ftp://dickey.his.com/ncurses/5.2/${P}-20010602.patch.gz
         ftp://dickey.his.com/ncurses/5.2/${P}-20010526.patch.gz
         ftp://dickey.his.com/ncurses/5.2/${P}-20010519.patch.gz"

HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"
DEPEND="virtual/glibc"
src_unpack() {
  unpack ${P}.tar.gz
  cd ${S}
  try sh ${DISTDIR}/patch-5.2-20010512.sh
  try gzip -dc ${DISTDIR}/${P}-20010519.patch.gz | patch -p1
  try gzip -dc ${DISTDIR}/${P}-20010526.patch.gz | patch -p1
  try gzip -dc ${DISTDIR}/${P}-20010602.patch.gz | patch -p1
  try gzip -dc ${DISTDIR}/${P}-20010603.patch.gz | patch -p1
  try gzip -dc ${DISTDIR}/${P}-20010609.patch.gz | patch -p1
  try gzip -dc ${DISTDIR}/${P}-20010616.patch.gz | patch -p1
  try gzip -dc ${DISTDIR}/${P}-20010618.patch.gz | patch -p1
}

src_compile() {

    if [ -z "$DEBUG" ]
    then
      myconf="${myconf} --without-debug"
    fi
        rm -rf test
	try ./configure --prefix=/usr --libdir=/lib --mandir=/usr/share/man \
		--enable-symlinks --enable-termcap \
		--with-shared --with-rcs-ids \
		--host=${CHOST}  ${myconf}

        echo "all:" > test/Makefile
        # Parallel make fails sometimes so I removed MAKEOPTS
	try make

}

src_install() {

        dodir /usr/lib
        echo "install:" >> test/Makefile
	try make DESTDIR=${D} install

	cd ${D}/lib
	ln -s libncurses.a libcurses.a
	chmod 755 ${D}/lib/*.${PV}
        dodir /usr/lib
        mv libform* libmenu* libpanel* ../usr/lib
        mv *.a ../usr/lib

	cd ${S}

	dodoc ANNOUNCE MANIFEST NEWS README* TO-DO
	dodoc doc/*.doc
	docinto html
	dodoc doc/html/*.html
	docinto html/ada
	dodoc doc/html/ada/*.htm
	docinto html/ada/files
	dodoc doc/html/ada/files/*.htm
	docinto html/ada/funcs
	dodoc doc/html/ada/funcs/*.htm
	docinto html/man
	dodoc doc/html/man/*.html

	#with this fix, the default xterm has color as it should
	cd ${D}/usr/share/terminfo/x
	mv xterm xterm.orig
	ln -s xterm-color xterm

}



