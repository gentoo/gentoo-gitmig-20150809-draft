# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/w3m/w3m-0.1.10-r1.ebuild,v 1.1 2000/08/10 01:53:40 achim Exp $

P=w3m-0.1.10
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="net-www"
DESCRIPTION="Text based WWW browser, supports tables and frames"
SRC_URI="ftp://ei5nazha.yz.yamagata-u.ac.jp/w3m/${A}
	 ftp://ftp.umlauf.de/pub/w3m/${A}"
HOMEPAGE="http://ei5nazha.yz.yamagata-u.ac.jp/~aito/w3m/eng/"
src_unpack() {
  unpack ${A}
  cd ${S}
  zcat ${O}/files/${P}.diff.gz | patch -p1
  sed -e "s:^def_libdir.*:def_libdir='/usr/libexec/w3m':" \
      -e "s:^def_helpdir.*:def_helpdir='/usr/doc/${P}/html':" \
      -e "s:gentoolinux\.mydomain:${HOSTNAME}:" \
	${O}/files/config.param > config.param
}

src_compile() {                           
  cd ${S}
  ./configure --prefix=/usr --nonstop -lang=en -model=monster -cflags="${CFLAGS}"
  make
}

src_install() {                               
  cd ${S}
  make DESTDIR=${D} install
  dodoc doc/README* doc/*.default doc/menu.submenu doc/HISTORY
  doman doc/w3m.1
}





