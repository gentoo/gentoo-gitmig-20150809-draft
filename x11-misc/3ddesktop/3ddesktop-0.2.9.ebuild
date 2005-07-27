# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/3ddesktop/3ddesktop-0.2.9.ebuild,v 1.3 2005/07/27 10:21:35 pvdabeel Exp $

DESCRIPTION="OpenGL virtual desktop switching"
HOMEPAGE="http://desk3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/desk3d/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

DEPEND="virtual/x11
	media-libs/imlib2
	x11-base/opengl-update"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc README AUTHORS TODO ChangeLog README.windowmanagers
}

pkg_postinst() {
	einfo
	einfo "This ebuild installed a configuration file called /etc/3ddesktop.conf"
	einfo "The default configuration makes a screenshot of the virtual desktops"
	einfo "every X seconds. This is non-optimal behavior."
	einfo
	einfo "To enable a more intelligent way of updating the virtual desktops,"
	einfo "execute the following:"
	einfo
	einfo "  echo \"AutoAcquire 0\" >> /etc/3ddesktop.conf"
	einfo
	einfo "This will cause 3ddesktop to update the virtual desktop snapshots"
	einfo "only when a 3d desktop switch is required."
	einfo
}
