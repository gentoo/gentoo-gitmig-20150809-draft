# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>

S=${WORKDIR}/${P}
DESCRIPTION="Desktop Organizer Software for the Palm Pilot"
SRC_URI="http://jpilot.org/${P}.tar.gz"
HOMEPAGE="http://jpilot.org/"

DEPEND=">=x11-libs/gtk+-1.2.0 >=dev-libs/pilot-link-0.9.0"

src_compile() {

  local myconf
  if [ -z "`use nls`" ] ; then
	NLS_OPTION="--disable-nls"
  fi

  try ./configure --prefix=/usr/X11R6 --host=${CHOST} ${NLS_OPTION}

  # cheap fix?
  patch -p0 < ${FILESDIR}/${P}.patch

  # make sure we use $CFLAGS
  mv Makefile Makefile.old
  sed -e "s/-g -O2/${CFLAGS}/" Makefile.old > Makefile

  try pmake
}

src_install() {

  make prefix=${D}/usr/X11R6 install
  dodoc README TODO UPGRADING ABOUT-NLS BUGS\
	CHANGELOG COPYING CREDITS INSTALL
  doman docs/*.1 
}

