# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
A="${P}.tar.gz jpilot-syncmal_0.62.tar.gz malsync_2.0.6.src.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Desktop Organizer Software for the Palm Pilot"
SRC_URI="http://jpilot.org/${P}.tar.gz
http://www.tomw.org/malsync/malsync_2.0.6.src.tar.gz
http://people.atl.mediaone.net/jasonday/code/syncmal/jpilot-syncmal_0.62.tar.gz"
HOMEPAGE="http://jpilot.org/"
# In order to use the malsync plugin you'll need to refer to the homepage
# for jpilot-syncmal http://people.atl.mediaone.net/jasonday/code/syncmal/
# And you'll also need an avangto account. 

DEPEND=">=x11-libs/gtk+-1.2.0 >=dev-libs/pilot-link-0.9.5"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	unpack jpilot-syncmal_0.62.tar.gz
	cd ${S}/jpilot-syncmal_0.62
	unpack malsync_2.0.6.src.tar.gz
}

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

  try make

  cd ${S}/jpilot-syncmal_0.62
  try ./configure --prefix=/usr/X11R6 --host=${CHOST}
  make
}

src_install() {

  make prefix=${D}/usr/X11R6 install
  insinto /usr/X11R6/share/jpilot/plugins
  doins jpilot-syncmal_0.62/.libs/libsyncmal.so
  dodoc README TODO UPGRADING ABOUT-NLS BUGS\
	CHANGELOG COPYING CREDITS INSTALL
	doman docs/*.1
   newdoc jpilot-syncmal_0.62/ChangeLog ChangeLog.jpilot-syncmal
	newdoc jpilot-syncmal_0.62/README.1st README.1st.jpilot-syncmal
   newdoc jpilot-syncmal_0.62/README README.jpilot-syncmal
	dodoc jpilot-syncmal_0.62/malsync/Doc/README_AvantGo 
   dodoc jpilot-syncmal_0.62/malsync/Doc/README_malsync


}

