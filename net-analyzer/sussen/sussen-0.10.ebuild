# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sussen/sussen-0.10.ebuild,v 1.4 2005/03/23 01:56:37 vanquirius Exp $

inherit gnome2 mono

DESCRIPTION="Sussen is a tool for testing the security posture of computers and other network devices."
HOMEPAGE="http://sussen.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~x86 -sparc"

RDEPEND=">=dev-lang/mono-1.0
	=dev-dotnet/gtk-sharp-1.0*
	=dev-dotnet/glade-sharp-1.0*
	=dev-dotnet/gnome-sharp-1.0*"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper"

DOCS="AUTHORS COPYING ChangeLog INSTALL \
	  NEWS README TODO"

