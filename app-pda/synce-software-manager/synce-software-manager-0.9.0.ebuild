# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-software-manager/synce-software-manager-0.9.0.ebuild,v 1.2 2004/10/18 12:17:09 dholm Exp $

inherit gnome2

DESCRIPTION="Synchronize Windows CE devices with Linux. Graphical Software Manager"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=app-pda/synce-librapi2-0.9
	>=x11-libs/gtk+-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libglade-2.0"

USE_DESTDIR=1