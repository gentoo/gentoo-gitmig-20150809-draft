# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-mpris/pidgin-mpris-0.2.6.ebuild,v 1.2 2009/04/14 09:41:15 armin76 Exp $

DESCRIPTION="Gets current song from MPRIS-aware media players"
HOMEPAGE="http://m0n5t3r.info/work/pidgin-mpris/"
SRC_URI="http://m0n5t3r.info/stuff/pidgin-mpris//${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

RDEPEND="net-im/pidgin
	>=x11-libs/gtk+-2
	sys-apps/dbus"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc INSTALL README TODO
}
