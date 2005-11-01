# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/jaffm/jaffm-1.2.1.ebuild,v 1.4 2005/11/01 15:08:22 nelchael Exp $

inherit eutils

DESCRIPTION="Very lightweight file manager"
HOMEPAGE="http://jaffm.binary.is/"

SRC_URI="http://www.binary.is/download/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="virtual/x11
	>=x11-libs/wxGTK-2.6"

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${P}-wx24.patch"
}

src_compile() {
	emake || die
}

src_install() {
	dobin jaffm
	dodoc README
}
