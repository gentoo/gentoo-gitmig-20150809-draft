# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcp/wmcp-1.2.8.ebuild,v 1.16 2007/07/22 05:16:39 dberkholz Exp $

inherit eutils

IUSE=""
DESCRIPTION="A pager dockapp"
HOMEPAGE="http://www.dockapps.com/file.php/id/158"
SRC_URI="http://linux-sea.tucows.webusenet.com/files/x11/dock/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ia64 ppc ~sparc alpha hppa ~mips"

DEPEND="x11-proto/xproto
	x11-proto/xextproto
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch
	epatch ${FILESDIR}/${P}-gcc33.patch
}

src_compile() {
	make || die "make failed"
}

src_install() {
	cd ${S}
	dobin wmcp
	dodoc README
}
