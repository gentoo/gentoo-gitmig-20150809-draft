# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-2.8.1.ebuild,v 1.9 2005/04/02 03:52:26 geoman Exp $

inherit gnome2

DESCRIPTION="The GNOME PostScript document viewer"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64 mips"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/orbit-2.4.1
	virtual/ghostscript
	dev-libs/popt"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.30"

PROVIDE="virtual/psviewer"

DOCS="AUTHORS ChangeLog MAINTAINERS TODO README"
