# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/ogle-gui/ogle-gui-0.8.2.ebuild,v 1.1 2002/01/17 21:17:21 blocke Exp $

P="ogle_gui-0.8.2"
S=${WORKDIR}/${P}
DESCRIPTION="GUI interface for the Ogle DVD player"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

DEPEND=">=media-video/ogle-0.8.2 x11-libs/gtk+ dev-libs/libxml2 sys-devel/bison nls? ( sys-devel/gettext ) "

src_compile() {

  local myconf
  
  use nls || myconf="--disable-nls"

  ./configure --prefix=/usr --host=${CHOST} $myconf  || die
  make || die	

}

src_install() {
	
  make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info docdir=${D}/usr/share/doc/${PF}/html sysconfdir=${D}/etc install || die

  dodoc ABOUT-NLS AUTHORS COPYING INSTALL NEWS README
}

