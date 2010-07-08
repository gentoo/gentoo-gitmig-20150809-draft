# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-extprefs/pidgin-extprefs-0.7-r1.ebuild,v 1.5 2010/07/08 19:24:17 armin76 Exp $

EAPI=2

DESCRIPTION="Pidgin Extended Preferences is a plugin that takes advantage of existing pidgin functionality to provide preferences that are often desired but not are not considered worthy of inclusion in Pidgin itself."

HOMEPAGE="http://gaim-extprefs.sourceforge.net"

SRC_URI="mirror://sourceforge/gaim-extprefs/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64 ~hppa ppc sparc x86"

IUSE=""

RDEPEND="net-im/pidgin[gtk]"

DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_install() {
	make DESTDIR="${D}" install || die
}
