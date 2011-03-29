# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libpanelappletmm/libpanelappletmm-2.26.0.ebuild,v 1.6 2011/03/29 06:12:41 nirbheek Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="C++ interface for gnome panel"
HOMEPAGE="http://www.gtkmm.org/"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=dev-cpp/gconfmm-2.4
	>=dev-cpp/glibmm-2.4:2
	>=dev-cpp/gtkmm-2.4:2.4
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	<gnome-base/gnome-panel-2.91.6"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	dev-util/pkgconfig"
