S=${WORKDIR}/${P}
DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://www.gftp.org/${P}.tar.gz"
HOMEPAGE="http://www.gftp.org"

# very generic depends. it should be that way.
DEPEND="x11-libs/gtk+
	dev-libs/glib
        >=x11-base/xfree-4.1.0
	nls? ( sys-devel/gettext )"


src_compile() {
  local myconf
  if [ -z "`use nls`" ] ; then
     myconf="--disable-nls"
  fi
   pkg-config gtk+-2.0 && einfo "Gtk+ 2.0 found using that" || einfo "Using gtk+ 1.2" 
   pkg-config gtk+-2.0 && myconf="${myconf} --enable-gtk20" 
  ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man ${myconf} || die
  emake || die
}

src_install() {

  make prefix=${D}/usr mandir=${D}/usr/share/man install || die

  dodoc COPYING ChangeLog README* THANKS TODO
  dodoc docs/USERS-GUIDE

}
