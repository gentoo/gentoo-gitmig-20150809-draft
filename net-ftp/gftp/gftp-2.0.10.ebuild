# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authors Achim Gottinger <achim@gentoo.org>, Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/gftp/gftp-2.0.10.ebuild,v 1.3 2002/05/23 06:50:15 seemant Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://www.gftp.org/${P}.tar.gz"
HOMEPAGE="http://www.gftp.org"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
        >=x11-base/xfree-4.1.0
	nls? ( sys-devel/gettext )"


src_compile() {
  local myconf
  if [ -z "`use nls`" ] ; then
     myconf="--disable-nls"
  fi
  ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man ${myconf} || die
  emake || die
}

src_install() {

  make prefix=${D}/usr mandir=${D}/usr/share/man install || die

  dodoc COPYING ChangeLog README* THANKS TODO
  dodoc docs/USERS-GUIDE

}





