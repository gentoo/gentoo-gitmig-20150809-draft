# Distributed under the terms of the GNU General Public License, v2 or later
# Author Nathaniel Hirsch <nh2@njit.edu> Achim Gottinge <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/media-video/vlc/vlc-0.2.80.ebuild,v 1.1 2001/06/20 13:47:39 darks Exp
# $Header: /var/cvsroot/gentoo-x86/gnome-libs/gnomemm/gnomemm-1.1.21.ebuild,v 1.4 2001/08/31 23:32:48 hallski Exp $


S=${WORKDIR}/${P}
DESCRIPTION="C++ binding for the GNOME libraries"
SRC_URI="http://prdownloads.sourceforge.net/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

RDEPEND=">=x11-libs/gtkmm-1.2.5
	 >=gnome-base/ORBit-0.5.8"

DEPEND="${RDEPEND}"

src_compile() {
	./configure --host=${CHOST} --prefix=/opt/gnome || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}
