# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libelysiumui/libelysiumui-0.2.0.ebuild,v 1.10 2011/03/02 18:16:21 signals Exp $

EAPI=2

DESCRIPTION="User Interface enhancements for Elysium GNU/Linux"
HOMEPAGE="http://elysium-project.sourceforge.net"
SRC_URI="mirror://sourceforge/elysium-project/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	gnome-base/gnome-vfs:2
	gnome-base/gconf:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
}
