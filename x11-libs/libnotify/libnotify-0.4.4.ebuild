# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libnotify/libnotify-0.4.4.ebuild,v 1.6 2007/07/12 18:13:32 jer Exp $

inherit eutils

DESCRIPTION="Notifications library"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~ppc ppc64 ~sh sparc ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.6
		>=dev-libs/glib-2.6
		||	(
				( >=dev-libs/dbus-glib-0.71 )
				>=sys-apps/dbus-0.60
			)
		|| ( x11-misc/notification-daemon xfce-extra/notification-daemon-xfce )"
DEPEND="${RDEPEND}
		doc? ( >=dev-util/gtk-doc-1.4 )"

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS
}
