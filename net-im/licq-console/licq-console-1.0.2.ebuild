# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/licq-console/licq-console-1.0.2.ebuild,v 1.11 2002/09/23 20:13:38 vapier Exp $


LICQV=licq-1.0.4
S=${WORKDIR}/${P}
DESCRIPTION="Enables you to use Licq from the console using a ncurses 'GUI'"
SRC_URI="mirror://sourceforge/licq/${LICQV}.tar.gz
         ftp://ftp.fanfic.org/pub/licq/srcs/${LICQV}.tar.gz
         ftp://licq.darkorb.net/${LICQV}.tar.gz"
HOMEPAGE="http://www.licq.org/"
SLOT="0"
LICENSE="GPL-2 QPL-1.0"
KEYWORDS="x86"
DEPEND="virtual/glibc sys-devel/gcc
        >=sys-libs/ncurses-5.2
        >=net-im/licq-1.0.3"

RDEPEND="virtual/glibc sys-devel/gcc
        >=sys-libs/ncurses-5.2"

src_compile() {
  cd ${WORKDIR}/${LICQV}/plugins/console-${PV}
  ./configure --host=${CHOST} --prefix=/usr --with-licq-includes=/usr/include/licq || die
  make || die
}

src_install() {
  cd ${WORKDIR}/${LICQV}/plugins/console-${PV}
  make prefix=${D}/usr install || die
  dodoc README
}

