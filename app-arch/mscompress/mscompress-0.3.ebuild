# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/mscompress/mscompress-0.3.ebuild,v 1.11 2006/10/04 12:40:37 blubb Exp $

inherit eutils

DESCRIPTION="Microsoft compress.exe/expand.exe compatible (de)compressor"
HOMEPAGE="http://www.penguin.cz/~mhi/ftp/mscompress/"
SRC_URI="http://www.penguin.cz/~mhi/ftp/mscompress/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~hppa ~ppc ~ppc-macos x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_install() {
	dobin mscompress msexpand || die
	doman mscompress.1 msexpand.1
	dodoc README ChangeLog
}
