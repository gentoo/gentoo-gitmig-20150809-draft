# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/thunar/thunar-0.8.0.ebuild,v 1.3 2007/01/28 14:37:31 welp Exp $

inherit xfce44

MY_P="${P/t/T}"
S="${WORKDIR}/${MY_P}"

xfce44

DESCRIPTION="File manager"
HOMEPAGE="http://thunar.xfce.org"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc dbus debug exif gnome hal plugins pcre startup-notification"

RDEPEND=">=dev-lang/perl-5.6
	x11-libs/libSM
	>=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.6
	>=xfce-extra/exo-0.3.2
	>=x11-misc/shared-mime-info-0.15
	>=dev-util/desktop-file-utils-0.10
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	virtual/fam
	dbus? ( dev-libs/dbus-glib )
	hal? ( sys-apps/hal )
	>=media-libs/freetype-2.0
	gnome? ( gnome-base/gconf )
	exif? ( >=media-libs/libexif-0.6 )
	>=media-libs/jpeg-6b
	startup-notification? ( x11-libs/startup-notification )
	pcre? ( >=dev-libs/libpcre-6 )
	plugins? ( dbus? ( >=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION} ) )
	gnome-base/librsvg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	doc? ( dev-util/gtk-doc )"

XFCE_CONFIG="${XFCE_CONFIG} $(use_enable exif) $(use_enable gnome gnome-thumbnailers) \
	$(use_enable dbus) $(use_with hal volume-manager hal) $(use_enable pcre)"

use plugins && use dbus || XFCE_CONFIG="${XFCE_CONFIG} --disable-tpa-plugin"

pkg_setup() {
	if use plugins && ! use dbus ; then
	ewarn "Plugins requires ${PN} with dbus support. Enable dbus use flag"
	ewarn "and re-emerge this ebuild if you want this feature."
	epause 3
	fi
}

DOCS="AUTHORS ChangeLog HACKING FAQ THANKS TODO README NEWS"

xfce44_extra_package
