# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/metamail/metamail-2.7-r2.ebuild,v 1.1 2000/11/15 21:56:01 achim Exp $

P=metamail-2.7
A=mm2.7.tar.Z
S=${WORKDIR}/mm2.7/src
DESCRIPTION="Metamail"
SRC_URI="ftp://thumper.bellcore.com/pub/nsb/${A}
	 ftp://ftp.bora.net/pub/free_servers/mail/metamail/${A}"

DEPEND=">=x11-base/xfree-4.0.1"

src_unpack() {
  unpack ${A}
  cd ${S}
  for i in make fonts glibc csh uudecode sunqote \
        ohnonotagain arghhh
  do
    echo
    echo "Applying $i patch ..."
    patch -p2 < ${FILESDIR}/mm-2.7-$i.patch
  done
  patch -p2 < ${FILESDIR}/metamail-2.7-nl.patch

   cp Makefile Makefile.orig
  sed -e "s:^CFLAGS =.*:CFLAGS = -fsigned-char -g -pipe -DLINUX -I \. ${CFLAGS}:" Makefile.orig > Makefile
  cd metamail
  cp Makefile Makefile.orig
  sed -e "s/-ltermcap/-lncurses/" Makefile.orig > Makefile
  cd ../richmail
  cp Makefile Makefile.orig
  sed -e "s/-ltermcap/-lncurses/" Makefile.orig > Makefile

}

src_compile() {                           
  cd ${S}
  try make
  try make -C fonts
}

src_install() {                               
  cd ${S}
  into /usr
  dobin bin/*
  doman man/*
  dodoc CREDITS README mailers.txt
  insinto /usr/X11R6/lib/X11/fonts/misc
  doins fonts/*.pcf
}



