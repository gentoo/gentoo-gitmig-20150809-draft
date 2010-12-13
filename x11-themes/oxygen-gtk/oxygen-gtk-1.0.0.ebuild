# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/oxygen-gtk/oxygen-gtk-1.0.0.ebuild,v 1.2 2010/12/13 17:57:48 spatz Exp $

EAPI=3

inherit cmake-utils

DESCRIPTION="(yet another) Gtk port of KDE's oxygen widget style"
HOMEPAGE="https://projects.kde.org/projects/playground/artwork/oxygen-gtk"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+
	x11-libs/cairo
	dev-libs/glib
	x11-libs/libX11
	x11-libs/pango"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
