# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kf/kf-0.1.3.ebuild,v 1.6 2008/03/14 10:21:54 phreak Exp $

DESCRIPTION="kf is a simple Jabber messenger."
HOMEPAGE="http://www.habazie.rams.pl/kf/"
SRC_URI="http://www.habazie.rams.pl/kf/files/${P}.tar.gz"
LICENSE="GPL-2"
DEPEND=">=x11-libs/gtk+-2
	>=net-libs/loudmouth-0.15.1
	>=gnome-base/libglade-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"

src_install() {
	make install DESTDIR="${D}" || die 'make install failed'
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
