# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtksourceview-sharp/gtksourceview-sharp-2.24.0-r5.ebuild,v 1.1 2009/01/05 17:18:42 loki_val Exp $

EAPI=2

GTK_SHARP_REQUIRED_VERSION="2.12"
GTKSOURCEVIEW_REQUIRED_VERSION=2.4.1

inherit gtk-sharp-module

SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="test"
