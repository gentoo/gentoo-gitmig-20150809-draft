# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jules Gagnon <eonwe@users.sourceforge.net>

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
  if [ -z "`use ssl`" ]
  then
    myconf="--disable-openssl"
  fi

  if [ "`use socks5`" ]
  then
    myconf="${myconf} --enable-socks5"
  fi

  try ./configure --host=${CHOST} --prefix=/usr ${myconf}
  try make

  if [ "`use qt`" ]
  then
    local myconf2
    if [ "`use kde`" ]
    then
      myconf2="--with-kde"
    fi
    cd ./plugins/qt-gui-1.0.3
    try ./configure --host=${CHOST} --prefix=/usr ${myconf2}
    try make
    cd ../..
  fi
}

src_install() { 
  try make prefix=${D}/usr install
  dodoc README.OPENSSL doc/*

  if [ "`use qt`" ]
  then
    cd ./plugins/qt-gui-1.0.3
    try make prefix=${D}/usr install
    cd ../..
  fi
}

