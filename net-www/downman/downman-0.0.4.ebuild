# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/downman/downman-0.0.4.ebuild,v 1.1 2003/10/29 02:09:47 seemant Exp $

inherit gnome2

DESCRIPTION="Download Manager (aka downman) is a suite of programs to download files"
HOMEPAGE="http://downman.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	>=gnome-base/libgnome-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libglade-2.0
	>=dev-libs/libxml2-2.0"

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING README INSTALL NEWS"
