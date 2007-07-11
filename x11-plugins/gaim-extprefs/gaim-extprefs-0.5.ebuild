# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-extprefs/gaim-extprefs-0.5.ebuild,v 1.6 2007/07/11 20:39:23 mr_bones_ Exp $

DESCRIPTION="Gaim Extended Preferences is a plugin that takes advantage of existing gaim functionality to provide preferences that are often desired but not are not considered worthy of inclusion in Gaim itself."

HOMEPAGE="http://gaim-extprefs.sourceforge.net"

SRC_URI="mirror://sourceforge/gaim-extprefs/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64 ppc sparc x86"

IUSE=""

DEPEND="dev-util/pkgconfig
	>=net-im/gaim-1.0.0"
#RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
