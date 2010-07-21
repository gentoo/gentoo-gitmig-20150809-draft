# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtk2fontsel/gtk2fontsel-0.1.ebuild,v 1.1 2010/07/21 19:20:51 ssuominen Exp $

EAPI=2

DESCRIPTION="A font selection tool similar to xfontsel"
HOMEPAGE="http://gtk2fontsel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README
}
