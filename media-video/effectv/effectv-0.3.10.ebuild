# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/effectv/effectv-0.3.10.ebuild,v 1.4 2007/07/12 02:40:42 mr_bones_ Exp $

inherit eutils toolchain-funcs

DESCRIPTION="EffecTV is a real-time video effect-processor"
HOMEPAGE="http://effectv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mmx"
DEPEND="x86? ( dev-lang/nasm )
		media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-makefile.patch"
	epatch "${FILESDIR}/${P}-trunc-name-collision.patch"
}

src_compile() {
	local mmx
	local nasm

	use mmx && mmx="yes" || mmx="no"
	[[ $(tc-arch) == "x86" ]] && nasm="yes" || nasm="no"

	emake CC="$(tc-getCC)" PREFIX="/usr" CFLAGS.opt="${CFLAGS}" \
		USE_MMX=${mmx} USE_NASM=${nasm} ARCH= || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe ${PN}
	doman *.1
	dodoc CREWS ChangeLog FAQ NEWS README TODO
}
