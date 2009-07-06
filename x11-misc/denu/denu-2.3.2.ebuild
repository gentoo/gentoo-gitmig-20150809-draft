# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/denu/denu-2.3.2.ebuild,v 1.8 2009/07/06 11:18:55 ssuominen Exp $

DESCRIPTION="A menu generation program for fluxbox, waimea, openbox, icewm, gnome and kde."
HOMEPAGE="http://denu.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ~ppc64 x86"
IUSE=""

RDEPEND="dev-lang/python
	>=dev-python/pygtk-2.4.1"
DEPEND="${RDEPEND}"

src_install() {
	./install.sh "${D}" || die "./install.sh failed"
}
