# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/pidgin-festival/pidgin-festival-2.4.ebuild,v 1.1 2009/12/21 21:02:03 pva Exp $

EAPI=2

DESCRIPTION="A plugin for pidgin which enables text-to-speech output of conversations using festival."
HOMEPAGE="http://sourceforge.net/projects/pidgin-festival/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="app-accessibility/festival
	net-im/pidgin[gtk]
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog || die
}
