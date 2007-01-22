# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/exo/exo-0.3.2.ebuild,v 1.1 2007/01/22 02:12:39 nichoj Exp $

inherit xfce44

xfce44
xfce44_extra_package

DESCRIPTION="Libraries for Xfce 4 designed for application development"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug doc hal libnotify python"

RDEPEND="
	>=dev-util/intltool-0.31
	>=dev-lang/perl-5.6
	dev-perl/URI
	>=dev-libs/glib-2.6.4
	>=x11-libs/gtk+-2.6
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-plugins-${XFCE_MASTER_VERSION}
	doc? ( >=dev-util/gtk-doc-1.0 )
	libnotify? ( >=x11-libs/libnotify-0.4 )
	hal? ( >=sys-apps/hal-0.5 )
	python? (
		>=dev-lang/python-2.2
		>=dev-python/pygtk-2.4.0
	)"
DEPEND="${RDEPEND}
	dev-python/pygtk
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}"

XFCE_CONFIG="${XFCE_CONFIG}	$(use_enable doc gtk-doc) \
	$(use_enable python) $(use_enable libnotify notifications) \
	$(use_enable hal) --enable-mcs-plugin"
