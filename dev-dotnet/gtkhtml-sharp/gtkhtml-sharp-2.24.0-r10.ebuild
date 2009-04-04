# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtkhtml-sharp/gtkhtml-sharp-2.24.0-r10.ebuild,v 1.3 2009/04/04 14:33:46 maekke Exp $

EAPI=2

GTK_SHARP_REQUIRED_VERSION="2.12"

inherit gtk-sharp-module versionator

SLOT="2"
KEYWORDS="amd64 ppc x86"
IUSE=""

RESTRICT="test"
