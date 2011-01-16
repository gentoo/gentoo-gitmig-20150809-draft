# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4ui/libxfce4ui-4.8.0.ebuild,v 1.1 2011/01/16 16:31:23 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Xfce's unified widgets library"
HOMEPAGE="http://www.xfce.org/projects/libraries/"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.8/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="debug glade startup-notification"

RDEPEND="x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	>=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfconf-4.8
	glade? ( dev-util/glade:3 )
	startup-notification? ( x11-libs/startup-notification )
	!<xfce-base/libxfcegui4-4.7.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	dev-lang/perl"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable startup-notification)
		$(use_enable glade gladeui)
		$(xfconf_use_debug)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
}
