# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/swiftfxp/swiftfxp-0.4.4.ebuild,v 1.3 2006/03/20 00:12:19 halcy0n Exp $

inherit eutils

DESCRIPTION="GTK based FXP Client clone of FlashFXP"
HOMEPAGE="http://sourceforge.net/projects/swiftfxp/"
SRC_URI="mirror://sourceforge/swiftfxp/SwiftFXP-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND="=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	app-arch/unzip"

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
