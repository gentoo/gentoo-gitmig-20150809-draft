# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmufo/wmufo-1.2.0.ebuild,v 1.4 2004/11/25 15:44:08 weeve Exp $

inherit eutils

IUSE=""

DESCRIPTION="This is wmseti on steroids, yet another WMaker DockApp to see the progress of work unit analysis for the Seti@Home project."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

HOMEPAGE="http://wmseti.sourceforge.net/"

SLOT="0"
KEYWORDS="x86 ~sparc"
LICENSE="GPL-2"

DEPEND="virtual/x11
	>=dev-util/pkgconfig-0.15.0
	>=x11-libs/gtk+-2.2.4-r1"

src_install () {
	einstall || die "make install failed"

	dodoc AUTHORS ALL_I_GET_IS_AN_ALIEN_FACE ChangeLog INSTALL NEWS README
}
