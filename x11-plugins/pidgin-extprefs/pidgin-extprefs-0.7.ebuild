# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-extprefs/pidgin-extprefs-0.7.ebuild,v 1.8 2007/10/26 02:14:04 seemant Exp $

DESCRIPTION="Pidgin Extended Preferences is a plugin that takes advantage of existing pidgin functionality to provide preferences that are often desired but not are not considered worthy of inclusion in Pidgin itself."

HOMEPAGE="http://gaim-extprefs.sourceforge.net"

SRC_URI="mirror://sourceforge/gaim-extprefs/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64 hppa ppc sparc x86"

IUSE=""

DEPEND="dev-util/pkgconfig
	net-im/pidgin"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
}
