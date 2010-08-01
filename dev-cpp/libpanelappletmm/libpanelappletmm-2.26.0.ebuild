# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libpanelappletmm/libpanelappletmm-2.26.0.ebuild,v 1.3 2010/08/01 11:00:06 fauli Exp $

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="C++ interface for gnome panel"
HOMEPAGE="http://www.gtkmm.org/"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-cpp/gconfmm-2.4
	>=dev-cpp/glibmm-2.4
	>=dev-cpp/gtkmm-2.4
	>=gnome-base/gnome-panel-2.14"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	dev-util/pkgconfig"
