# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfmedia/xfmedia-0.9.2-r1.ebuild,v 1.4 2007/01/29 20:18:32 welp Exp $

inherit xfce44

DESCRIPTION="Media player frontend for xine-lib"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfmedia"
SRC_URI="http://spuriousinterrupt.org/projects/${PN}/files/${P}.tar.bz2"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="dbus debug startup-notification"

RDEPEND="x11-libs/libX11
	x11-libs/libSM
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4util-4.2
	>=xfce-base/libxfcegui4-4.2
	>=media-libs/xine-lib-1
	xfce-extra/exo
	startup-notification? ( x11-libs/startup-notification )
	dbus? ( dev-libs/dbus-glib )
	media-libs/taglib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

XFCE_CONFIG="${XFCE_CONFIG} $(use_enable dbus)"

DOCS="AUTHORS ChangeLog NEWS TODO README README.plugins README.remote"
