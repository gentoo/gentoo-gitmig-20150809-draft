# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/drivel/drivel-0.9.1.ebuild,v 1.1 2003/05/20 07:28:57 liquidx Exp $

inherit gnome2

IUSE=""
DESCRIPTION="Drivel is a LiveJournal client for the GNOME desktop."
HOMEPAGE="http://sourceforge.net/project/drivel/"
SRC_URI="mirror://sourceforge/drivel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=x11-libs/gtk+-2.0.0
	>=gnome-base/libgnomeui-2.0.3
	>=gnome-base/gconf-1.2.1
	>=net-ftp/curl-7.10"
	
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"
	
DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS  README"
