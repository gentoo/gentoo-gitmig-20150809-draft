# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gnome-desktop-sharp/gnome-desktop-sharp-2.26.0.ebuild,v 1.4 2010/06/27 12:14:14 nixnut Exp $

EAPI=2

GTK_SHARP_REQUIRED_VERSION="2.12"
GTK_SHARP_MODULE_DIR="gnomedesktop"

inherit gtk-sharp-module

SLOT="2"
KEYWORDS="amd64 ppc x86"
IUSE=""

RESTRICT="test"
