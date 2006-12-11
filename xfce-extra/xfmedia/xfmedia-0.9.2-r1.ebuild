# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfmedia/xfmedia-0.9.2-r1.ebuild,v 1.2 2006/12/11 10:14:37 zmedico Exp $

inherit xfce44

DESCRIPTION="Xfce4 media player"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfmedia"
SRC_URI="http://spuriousinterrupt.org/projects/${PN}/files/${P}.tar.bz2"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="dbus debug startup-notification"

DEPEND=">=dev-util/intltool-0.31
	x11-libs/libX11
	x11-libs/libSM
	>=dev-libs/glib-2.6.0
	>=x11-libs/gtk+-2.6.0
	>=xfce-base/libxfce4util-4.2.0
	>=xfce-base/libxfcegui4-4.2.0
	>=media-libs/xine-lib-1.0.0
	>=xfce-extra/exo-0.2
	startup-notification? ( >=x11-libs/startup-notification-0.5 )
	dbus? ( || (
			>=dev-libs/dbus-glib-0.71
			( <sys-apps/dbus-0.90
			>=sys-apps/dbus-0.34 )
	) )
	media-libs/taglib"
RDEPEND="${DEPEND}"

XFCE_CONFIG="$(use_enable debug) \
	$(use_enable startup-notification) \
	$(use_enable dbus)"
