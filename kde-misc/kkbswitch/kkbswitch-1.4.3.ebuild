# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kkbswitch/kkbswitch-1.4.3.ebuild,v 1.4 2005/08/23 22:17:32 greg_g Exp $

inherit kde

DESCRIPTION="Keyboard layout indicator for KDE"
SRC_URI="mirror://sourceforge/kkbswitch/${P}.tar.gz"
HOMEPAGE="http://kkbswitch.sourceforge.net"
KEYWORDS="~ppc ~sparc x86"
SLOT="0"
LICENSE="GPL-2"

need-kde 3.1

src_install() {
	kde_src_install

	insinto /usr/share/pixmaps
	doins kkbswitch.xpm
}
