# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jules Gagnon <eonwe@users.sourceforge.net>
# $Header: /var/cvsroot/gentoo-x86/net-im/gtk+licq/gtk+licq-0.51.ebuild,v 1.1 2001/09/25 03:29:45 hallski Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtk+licq"
SRC_URI="http://gtk.licq.org/download/${A}"
HOMEPAGE="http://gtk.licq.org"

DEPEND="virtual/glibc sys-devel/perl nls? ( sys-devel/gettext )
        >=net-im/licq-1.0.2 gnome? ( >=gnome-base/gnome-core-1.4.0.4 )
	>=x11-libs/gtk+-1.2.0
        spell? ( >=app-text/pspell-0.11.2 )"

RDEPEND="virtual/glibc >=net-im/licq-1.0.2
	>=x11-libs/gtk+-1.2.0 gnome? ( >=gnome-base/gnome-core-1.4.0.4 )
        spell? ( >=app-text/pspell-0.11.2 )"


src_compile() {
  local myconf
  local myprefix
  myprefix="/opt/gnome"
  if [ -z "`use gnome`" ]
  then
    myconf="--disable-gnome"
    myprefix="/usr/X11R6"
  fi
  if [ -z "`use spell`" ] ; then
    myconf="$myconf --disable-pspell"
  fi
  if [ -z "`use nls`" ]
  then
    myconf="${myconf} --disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=${myprefix} \
       --with-licq-includes=/usr/include/licq ${myconf}
  try make
}

src_install() {
  local myprefix
  myprefix="opt/gnome"
  if [ -z "`use gnome`" ]
  then
    myprefix="usr/X11R6"
  fi
  try make prefix=${D}/${myprefix} install
  dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
  mkdir -p ${D}/usr/lib/licq
  cd ${D}/usr/lib/licq
  ls  ../../../${myprefix}/lib/licq
  ln -s ../../../${myprefix}/lib/licq/* .
}
