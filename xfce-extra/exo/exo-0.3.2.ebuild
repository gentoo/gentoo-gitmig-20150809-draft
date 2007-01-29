# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/exo/exo-0.3.2.ebuild,v 1.3 2007/01/29 19:03:52 welp Exp $

inherit xfce44

xfce44
xfce44_extra_package

DESCRIPTION="Extra library"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug doc hal libnotify python"

RDEPEND=">=dev-lang/perl-5.6
	dev-perl/URI
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-plugins-${XFCE_MASTER_VERSION}
	libnotify? ( x11-libs/libnotify )
	hal? ( sys-apps/hal )
	python? ( dev-python/pygtk )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )
	dev-util/intltool"

XFCE_CONFIG="${XFCE_CONFIG}	$(use_enable python) \
	$(use_enable libnotify notifications) \
	$(use_enable hal) --enable-mcs-plugin"

DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"

xfce44_core_package
