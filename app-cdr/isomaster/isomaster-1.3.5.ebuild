# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/isomaster/isomaster-1.3.5.ebuild,v 1.1 2009/04/09 12:39:23 hanno Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Graphical CD image editor for reading, modifying and writing ISO images"
HOMEPAGE="http://littlesvr.ca/isomaster"
SRC_URI="http://littlesvr.ca/${PN}/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/isomaster-1.3.5-ldflags.diff" || die "epatch failed"
}

src_compile() {
	tc-export CC
	emake PREFIX="/usr" || die "emake failed."
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install || die "emake install failed."
	dodoc {CHANGELOG,CREDITS,README,TODO}.TXT
}
