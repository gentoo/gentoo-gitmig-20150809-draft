# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/licq/licq-1.0.3-r2.ebuild,v 1.5 2001/11/13 23:59:22 verwilst Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="licq"
SRC_URI="http://download.sourceforge.net/${PN}/${A}
	 ftp://ftp.fanfic.org/pub/${PN}/srcs/${A}
	 ftp://licq.darkorb.net/${A}
	 ftp://ftp.fr.licq.org/pub/${PN}/srcs/${A}
	 ftp://ftp.ru.licq.org/pub/${PN}/srcs/${A}
	 ftp://ftp.pt.licq.org/pub/mirrors/${PN}/srcs/${A}
	 ftp://mirror.itcnet.ro/pub/${PN}/srcs/${A}"
HOMEPAGE="http://www.licq.org"

DEPEND="virtual/glibc
        ssl? ( >=dev-libs/openssl-0.9.6 )
        qt? ( >=x11-libs/qt-x11-2.2.1 )
        kde? ( >=kde-base/kdebase-2.1 )"

src_compile() {                           
  local myconf
  local myconf2

  if [ -z "`use ssl`" ]
  then
    myconf="--disable-openssl"
  fi

  if [ "`use socks5`" ]
  then
    myconf="${myconf} --enable-socks5"
  fi

  ./configure --host=${CHOST} --prefix=/usr ${myconf} || die
  make || die

  if [ "`use qt`" ]
  then
    if [ "`use kde`" ]
    then
      myconf2="--with-kde"
    fi
    cd ./plugins/qt-gui-1.0.3
    ./configure --host=${CHOST} --prefix=/usr ${myconf2} || die
    make || die
    cd ../..
  fi
}

src_install() { 
  make prefix=${D}/usr install || die
  dodoc README.OPENSSL doc/*

  if [ "`use qt`" ]
  then
    cd ./plugins/qt-gui-1.0.3
    make prefix=${D}/usr install || die
    cd ../..
  fi
}

