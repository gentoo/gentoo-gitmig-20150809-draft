# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavsplit/wavsplit-1.2.1.ebuild,v 1.6 2007/07/11 19:30:24 mr_bones_ Exp $

inherit eutils toolchain-funcs

DESCRIPTION="WavSplit is a simple command line tool to split WAV files"
HOMEPAGE="http://sourceforge.net/projects/wavsplit/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc, -amd64: 1.0: "Only supports PCM wave format" error message.
KEYWORDS="x86"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	# remove precomplied binaries
	rm "${S}"/{wavren,wavsplit} || die
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-large-files.patch
}

src_compile(){
	emake CC="$(tc-getCC)" || die "make failed"
}
src_install() {
	dobin wavren wavsplit || die "dobin failed"
	doman wavren.1 wavsplit.1 || die "doman failed"
	dodoc BUGS CHANGES CREDITS README README.wavren || die "dodoc failed"
}
