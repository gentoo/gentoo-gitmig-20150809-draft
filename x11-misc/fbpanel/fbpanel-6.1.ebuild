# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpanel/fbpanel-6.1.ebuild,v 1.6 2010/10/24 14:47:08 ssuominen Exp $

EAPI=2

DESCRIPTION="light-weight X11 desktop panel"
HOMEPAGE="http://fbpanel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ppc ppc64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CHANGELOG CREDITS README
}
