# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4ui/libxfce4ui-4.7.3.ebuild,v 1.1 2010/09/05 20:13:28 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Unified widgets library for Xfce4, a libxfcegui4 replacement"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.7/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug glade startup-notification"

RDEPEND="x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	>=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/xfconf-4.6
	glade? ( dev-util/glade:3 )
	startup-notification? ( x11-libs/startup-notification )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	dev-lang/perl"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable startup-notification)
		$(use_enable glade gladeui)
		$(xfconf_use_debug)
		--with-html-dir=${EPREFIX}/usr/share/doc/${PF}/html"
	DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
}
