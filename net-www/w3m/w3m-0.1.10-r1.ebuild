# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/w3m/w3m-0.1.10-r1.ebuild,v 1.6 2000/11/02 08:31:53 achim Exp $

P=w3m-0.1.10
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Text based WWW browser, supports tables and frames"
SRC_URI="ftp://ftp.umlauf.de/pub/w3m/${A}"
#	 ftp://ei5nazha.yz.yamagata-u.ac.jp/w3m/${A}"

HOMEPAGE="http://ei5nazha.yz.yamagata-u.ac.jp/~aito/w3m/eng/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=dev-libs/openssl-0.9.6"

src_unpack() {
  unpack ${A}
  cd ${S}
  zcat ${O}/files/${P}.diff.gz | patch -p1
  sed -e "s:^def_libdir.*:def_libdir='/usr/libexec/w3m':" \
      -e "s:^def_helpdir.*:def_helpdir='/usr/doc/${PF}/html':" \
      -e "s:gentoolinux\.mydomain:${HOSTNAME}:" \
	${O}/files/config.param > config.param
}

src_compile() {                           
  cd ${S}
  try ./configure --prefix=/usr --nonstop -lang=en -model=monster -cflags="${CFLAGS}"
  try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  dodoc doc/README* doc/*.default doc/menu.submenu doc/HISTORY
  doman doc/w3m.1
}






