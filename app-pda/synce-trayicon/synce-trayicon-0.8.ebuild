# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-trayicon/synce-trayicon-0.8.ebuild,v 1.7 2008/05/21 12:48:15 drac Exp $

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=app-pda/synce-librapi2-0.8
	>=x11-libs/gtk+-2.0
	>=gnome-base/libgnomeui-2.0"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
