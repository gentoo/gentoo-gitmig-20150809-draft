# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-0.5.10b.ebuild,v 1.4 2002/08/01 11:59:02 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Advanced Linux Sound Architecture / Library"
SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${P}.tar.bz2"
HOMEPAGE="http://www.alsa-project.org/"

DEPEND="virtual/glibc virtual/alsa"
RDEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

src_compile() {                           

  ./configure --host=${CHOST} --prefix=/usr || die
  make || die

}

src_install() {

  make DESTDIR=${D} install || die
  dodoc ChangeLog COPYING

}




