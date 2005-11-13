# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/swiftfxp/swiftfxp-0.4.4.ebuild,v 1.1 2005/11/13 07:32:12 vapier Exp $

inherit eutils

DESCRIPTION="GTK based FXP Client clone of FlashFXP"
HOMEPAGE="http://sourceforge.net/projects/swiftfxp/"
SRC_URI="mirror://sourceforge/swiftfxp/SwiftFXP-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1*"

S=${WORKDIR}/SwiftFXP-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc BUGS ChangeLog README TODO
}
