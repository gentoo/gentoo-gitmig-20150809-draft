# Distributed under the terms of the GNU General Public License, v2 or later
# Author Nathaniel Hirsch <nh2@njit.edu> Achim Gottinge <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/media-video/vlc/vlc-0.2.80.ebuild,v 1.1 2001/06/20 13:47:39 darks Exp
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnomemm/gnomemm-1.2.0.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $


S=${WORKDIR}/${P}
DESCRIPTION="C++ binding for the GNOME libraries"
SRC_URI="http://prdownloads.sourceforge.net/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

DEPEND=">=x11-libs/gtkmm-1.2.5
	>=gnome-base/ORBit-0.5.8"

RDEPEND=">=x11-libs/gtkmm-1.2.5
	 >=gnome-base/ORBit-0.5.8"

src_compile(){
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
	}
src_install(){
  try make prefix=${D}/opt/gnome install

  dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}

