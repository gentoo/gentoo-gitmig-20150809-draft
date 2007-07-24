# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/freebirth/freebirth-0.3.2-r1.ebuild,v 1.1 2007/07/24 15:03:49 drac Exp $

inherit eutils

DESCRIPTION="Free software bass synthesizer step sequencer"
HOMEPAGE="http://www.bitmechanic.com/projects/freebirth"
SRC_URI="http://www.bitmechanic.com/projects/freebirth/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo-2.patch
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	dobin ${PN}
	insinto /usr/lib/${PN}/raw
	doins raw/*.raw
	dodoc CHANGES NEXT_VERSION README
	doicon xpm/${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN}.xpm
}
