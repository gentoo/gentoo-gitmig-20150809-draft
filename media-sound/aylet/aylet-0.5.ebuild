# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aylet/aylet-0.5.ebuild,v 1.1 2007/07/25 14:12:18 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Aylet plays music files in the .ay format."
HOMEPAGE="http://rus.members.beeb.net/aylet.html"
SRC_URI="http://ftp.ibiblio.org/pub/Linux/apps/sound/players/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-implicit-declaration.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -DDRIVER_OSS" ${PN} || die "emake failed."
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc ChangeLog NEWS README TODO
}
