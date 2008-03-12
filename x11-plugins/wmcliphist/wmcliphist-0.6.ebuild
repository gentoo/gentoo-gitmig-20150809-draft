# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcliphist/wmcliphist-0.6.ebuild,v 1.1 2008/03/12 14:18:11 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Dockable clipboard history application for Window Maker"
HOMEPAGE="http://linux.nawebu.cz/wmcliphist"
SRC_URI="http://linux.nawebu.cz/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	tc-export CC
	emake || die "emake failed."
}

src_install() {
	dobin ${PN}
	dodoc ChangeLog README
	newdoc .${PN}rc ${PN}rc.sample
}
