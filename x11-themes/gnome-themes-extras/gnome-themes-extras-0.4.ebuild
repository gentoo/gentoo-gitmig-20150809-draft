# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes-extras/gnome-themes-extras-0.4.ebuild,v 1.4 2004/01/16 21:23:30 darkspecter Exp $

inherit gnome2

DESCRIPTION="Additional themes for GNOME 2.2"
HOMEPAGE="http://librsvg.sourceforge.net/theme.php"

SLOT="0"
KEYWORDS="x86 ~sparc ppc"
IUSE=""
LICENSE="LGPL-2.1 GPL-2 DSL"

RDEPEND=">=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23"

DOCS="AUTHORS ChangeLog MAINTAINERS README TODO"

src_unpack() {
	unpack ${A}
	sed -e 's:gorilla-default:capplet-icons:' \
		-i ${S}/Gorilla/gtk-2.0/iconrc.in \
		-i ${S}/Gorilla/gtk-2.0/iconrc
}
