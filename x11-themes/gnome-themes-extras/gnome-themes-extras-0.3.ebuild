# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes-extras/gnome-themes-extras-0.3.ebuild,v 1.3 2003/09/08 22:32:48 todd Exp $

inherit gnome2

DESCRIPTION="Additional themes for GNOME 2.2"
HOMEPAGE="http://librsvg.sourceforge.net/theme.php"

SLOT="0"
KEYWORDS="~x86 ~sparc"

LICENSE="LGPL-2.1 GPL-2 DSL"

RDEPEND=">=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23"

DOCS="AUTHORS ChangeLog MAINTAINERS README TODO"
