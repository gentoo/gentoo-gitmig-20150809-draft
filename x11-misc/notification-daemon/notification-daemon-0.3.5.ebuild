# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/notification-daemon/notification-daemon-0.3.5.ebuild,v 1.1 2006/04/26 23:58:34 compnerd Exp $

inherit gnome2

DESCRIPTION="Notifications daemon"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/glib-2.4.0
		>=x11-libs/gtk+-2.4.0
		>=gnome-base/gconf-2.4.0
		>=x11-libs/libsexy-0.1.3
		>=sys-apps/dbus-0.36
		x11-libs/libwnck
		dev-libs/popt"
RDEPEND="${DEPEND}
		 >=sys-devel/gettext-0.14"

DOCS="AUTHORS ChangeLog NEWS"
