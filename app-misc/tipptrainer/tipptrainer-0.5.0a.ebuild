# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tipptrainer/tipptrainer-0.5.0a.ebuild,v 1.4 2004/08/03 11:46:07 dholm Exp $

DESCRIPTION="A touch typing trainer (German/English)"
HOMEPAGE="http://www.pingos.org/tipptrainer/index.php"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/glib-1.2.7
	>=x11-libs/wxGTK-2.4.0"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
