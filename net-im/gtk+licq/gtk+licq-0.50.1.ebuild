# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jules Gagnon <eonwe@users.sourceforge.net>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtk+licq"
SRC_URI="http://gtk.licq.org/download/${A}"
HOMEPAGE="http://gtk.licq.org"

DEPEND=">=net-im/licq-1.0.2
	>=x11-libs/gtk+-1.2.0"

src_unpack() {
  unpack ${A}
  cd ${S}
}

src_compile() {                           
  local myconf
  local myprefix
  myprefix="/opt/gnome"
  if [ -z "`use gnome`" ]
  then
    myconf="--disable-gnome"
    myprefix="/usr/X11R6"
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
  if [ -z "`use gnome`"]
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
