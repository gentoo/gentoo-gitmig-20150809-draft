# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/root-portal/root-portal-0.5.0.ebuild,v 1.4 2004/01/16 00:15:09 tseng Exp $

inherit gnome2 debug

DESCRIPTION="A program to draw text and graphs in the root window"
HOMEPAGE="http://root-portal.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DOC="PACKAGING README NEWS ChangeLog BUGS AUTHORS README.help TODO"

RDEPEND="virtual/x11
	>=x11-libs/gtk+-2
	>=x11-libs/libzvt-2
	>=gnome-base/ORBit2-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2
	>=dev-libs/libxml2-2"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig"
