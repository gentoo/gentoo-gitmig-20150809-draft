# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/effectv/effectv-0.3.11.ebuild,v 1.4 2008/08/31 04:49:27 mr_bones_ Exp $

inherit eutils toolchain-funcs

DESCRIPTION="EffecTV is a real-time video effect-processor"
HOMEPAGE="http://effectv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mmx"

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}/${PN}-0.3.10-makefile.patch" \
		"${FILESDIR}/${PN}-0.3.10-trunc-name-collision.patch" \
		"${FILESDIR}/${P}-timedist.patch"
	echo "
%ifidn __OUTPUT_FORMAT__,elf
section .note.GNU-stack noalloc noexec nowrite progbits
%endif" >> effects/blurzoomcore.nas
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
	dobin ${PN} || die "dobin failed"
	doman *.1
	dodoc CREWS ChangeLog FAQ NEWS README TODO
}
