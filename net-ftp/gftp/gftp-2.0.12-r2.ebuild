# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/gftp/gftp-2.0.12-r2.ebuild,v 1.1 2002/07/06 23:30:33 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://www.gftp.org/${P}.tar.gz"
HOMEPAGE="http://www.gftp.org"
LICENSE="GPL-2"
SLOT="0"

# very generic depends. it should be that way.
DEPEND="x11-libs/gtk+
	dev-libs/glib
	>=x11-base/xfree-4.1.0
	gtk2? ( >=x11-libs/gtk+-2.0.0 )
	nls? ( sys-devel/gettext )"

RDEPEND="${DEPEND}"

src_compile() {
  local myconf
  if [ -z "`use nls`" ] ; then
     myconf="--disable-nls"
  fi
  use gtk2 && myconf="${myconf} --enable-gtk20" 
  ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man ${myconf} || die
  emake || die
}

src_install() {

  make prefix=${D}/usr mandir=${D}/usr/share/man install || die

  dodoc COPYING ChangeLog README* THANKS TODO
  dodoc docs/USERS-GUIDE

}
