# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sussen/sussen-0.15.ebuild,v 1.2 2006/07/12 15:11:44 kugelfang Exp $

inherit gnome2 mono

DESCRIPTION="Sussen is a tool for testing the security posture of computers and other network devices."
HOMEPAGE="http://sussen.sourceforge.net/"
SRC_URI="http://dev.mmgsecurity.com/downloads/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
IUSE="doc"
SLOT="0"
KEYWORDS="~ppc -sparc ~x86"

RDEPEND="app-arch/rpm
	>=gnome-base/gnome-panel-2.6
	>=dev-lang/mono-1.1.10
	>=dev-dotnet/gtk-sharp-2.4
	>=dev-dotnet/glade-sharp-2.4
	>=dev-dotnet/gnome-sharp-2.4"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/monodoc-1.1 )
	dev-util/pkgconfig
	app-text/scrollkeeper"

DOCS="AUTHORS COPYING ChangeLog INSTALL \
	  NEWS README TODO"

USE_DESTDIR="1"
