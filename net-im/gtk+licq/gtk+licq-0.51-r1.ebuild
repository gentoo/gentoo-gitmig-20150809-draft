# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jules Gagnon <eonwe@users.sourceforge.net>
# $Header: /var/cvsroot/gentoo-x86/net-im/gtk+licq/gtk+licq-0.51-r1.ebuild,v 1.1 2001/10/06 10:08:19 azarah Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtk+licq"
SRC_URI="http://gtk.licq.org/download/${A}"
HOMEPAGE="http://gtk.licq.org"

DEPEND="virtual/glibc sys-devel/perl nls? ( sys-devel/gettext )
        >=net-im/licq-1.0.2 gnome? ( >=gnome-base/gnome-core-1.4.0.4-r1 )
	>=x11-libs/gtk+-1.2.10-r4
        spell? ( >=app-text/pspell-0.11.2 )"

RDEPEND="virtual/glibc >=net-im/licq-1.0.2
	>=x11-libs/gtk+-1.2.10-r4 gnome? ( >=gnome-base/gnome-core-1.4.0.4-r1 )
        spell? ( >=app-text/pspell-0.11.2 )"


src_compile() {
  local myconf
  local myprefix
  myprefix="/usr"
  if [ -z "`use gnome`" ] ; then
    myconf="--disable-gnome"
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
  myprefix="usr"
  try make prefix=${D}/${myprefix} install
  dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
  mkdir -p ${D}/usr/lib/licq
  cd ${D}/usr/lib/licq
  ls  ../../../${myprefix}/lib/licq
  ln -s ../../../${myprefix}/lib/licq/* .
}
