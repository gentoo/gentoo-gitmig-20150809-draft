# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnome-netstatus/gnome-netstatus-2.5.92.ebuild,v 1.2 2004/03/23 13:07:09 gustavoz Exp $

inherit gnome2

DESCRIPTION="Network interface information applet"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2.5.2
	>=gnome-base/gnome-panel-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"
