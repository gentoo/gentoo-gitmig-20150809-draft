# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/effectv/effectv-0.3.10.ebuild,v 1.1 2005/03/29 22:50:57 chriswhite Exp $

inherit eutils

DESCRIPTION="EffecTV is a real-time video effect-processor"
HOMEPAGE="http://effectv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mmx"
DEPEND="virtual/libc
		dev-lang/nasm
		media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd ${S}
	# modify path and comment out presets
	sed -i -e 's:/usr/local:/usr:' \
		-e 's:^USE_VLOOPBACK:#USE_VLOOPBACK:' \
		-e 's:^ARCH:#ARCH:' config.mk
	if ! use mmx; then
		sed -i -e 's:^USE_MMX:#USE_MMX:' config.mk
	fi
	# use Gentoo CFLAGS and compiler
	sed -i -e "s:\$(CONFIG.arch) \$(CFLAGS.opt):${CFLAGS}:" \
		-e "s:^CC:#CC:" Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe ${PN}
	doman *.1
	dodoc CREWS ChangeLog FAQ NEWS README TODO
}

