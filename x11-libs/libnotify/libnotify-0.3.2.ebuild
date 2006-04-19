# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libnotify/libnotify-0.3.2.ebuild,v 1.5 2006/04/19 15:27:00 gustavoz Exp $

DESCRIPTION="Notifications library"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.2.2
	>=dev-libs/glib-2.2.2
	>=sys-apps/dbus-0.36
	dev-libs/popt"
RDEPEND="${DEPEND}
	x11-misc/notification-daemon"

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS
}
