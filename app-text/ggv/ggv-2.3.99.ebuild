# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-2.3.99.ebuild,v 1.1 2003/09/07 22:32:10 foser Exp $

inherit gnome2

DESCRIPTION="The GNOME PostScript document viewer"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
SLOT="0"
LICENSE="GPL-2 FDL-1.1"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/ORBit2-2.4.1
	app-text/ghostscript
	dev-libs/popt"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21"

DOC="AUTHORS ChangeLog COPYING* MAINTAINERS TODO NEWS README"
