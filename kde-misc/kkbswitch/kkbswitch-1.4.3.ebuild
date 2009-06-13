# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kkbswitch/kkbswitch-1.4.3.ebuild,v 1.8 2009/06/13 23:40:55 scarabeus Exp $

inherit kde

DESCRIPTION="Keyboard layout indicator for KDE"
HOMEPAGE="http://kkbswitch.sourceforge.net/"
SRC_URI="mirror://sourceforge/kkbswitch/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="3.5"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

need-kde 3.1

PATCHES=(
	"${FILESDIR}/${PV}-fix-ldflags.patch"
)

src_install() {
	kde_src_install

	insinto /usr/share/pixmaps
	doins kkbswitch.xpm
}
