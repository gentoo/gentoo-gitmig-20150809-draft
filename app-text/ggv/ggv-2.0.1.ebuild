# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-2.0.1.ebuild,v 1.10 2003/12/09 17:34:10 lanius Exp $

inherit gnome2

DESCRIPTION="The GNOME PostScript document viewer"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
SLOT="0"
LICENSE="GPL-2 FDL-1.1"
KEYWORDS="x86 ppc alpha ~sparc hppa amd64"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/ORBit2-2.4.1
	virtual/ghostscript
	>=dev-libs/popt-1.6"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool"

DOCS="AUTHORS ChangeLog COPYING* MAINTAINERS TODO NEWS README"
