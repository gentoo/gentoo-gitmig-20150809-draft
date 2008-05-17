# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-extprefs/pidgin-extprefs-0.7.ebuild,v 1.9 2008/05/17 15:46:11 tester Exp $

DESCRIPTION="Pidgin Extended Preferences is a plugin that takes advantage of existing pidgin functionality to provide preferences that are often desired but not are not considered worthy of inclusion in Pidgin itself."

HOMEPAGE="http://gaim-extprefs.sourceforge.net"

SRC_URI="mirror://sourceforge/gaim-extprefs/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64 hppa ppc sparc x86"

IUSE=""

RDEPEND="net-im/pidgin"

DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
}
