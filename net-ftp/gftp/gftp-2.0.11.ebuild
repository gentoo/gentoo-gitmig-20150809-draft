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
