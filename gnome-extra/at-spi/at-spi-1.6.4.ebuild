# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.6.4.ebuild,v 1.14 2006/09/05 02:40:58 kumba Exp $

inherit gnome2

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="doc static"
RESTRICT="test"

RDEPEND=">=gnome-base/gail-1.3
	>=gnome-base/libbonobo-1.107
	>=dev-libs/atk-1.7.2
	>=x11-libs/gtk+-2
	dev-libs/popt
	>=gnome-base/orbit-2
	|| ( (
			x11-libs/cairo
	        x11-libs/libICE
	        x11-libs/libSM
	        x11-libs/libX11
			x11-libs/libXau
	        x11-libs/libXdmcp
	        x11-libs/libXi
	        x11-libs/libXtst
	        x11-libs/pango
		)
		virtual/x11 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

G2CONF="${G2CONF} $(use_enable static)"
