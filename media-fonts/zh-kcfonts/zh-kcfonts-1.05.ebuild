# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/zh-kcfonts/zh-kcfonts-1.05.ebuild,v 1.4 2004/04/03 23:34:33 spyderous Exp $

KCFONTS="zh-kcfonts-1.05.tgz"

DESCRIPTION="Kuo Chauo Chinese Fonts collection in BIG5 encoding"
SRC_URI="ftp://ftp.freebsd.org.tw/pub/i386/4.6.2-RELEASE/packages/x11-fonts/${P}.tgz"
HOMEPAGE=""	#No homepage exists that I am aware of or able to find

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"
S=${WORKDIR}/${PN}
CFONTDIR=/usr/X11R6/lib/X11/fonts/misc/

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_install() {
	dodir ${CFONTDIR}
	insinto ${CFONTDIR}
	doins ${S}/lib/X11/fonts/local/*
}

pkg_postinst() {
	mkfontdir ${CFONTDIR}
	cd ${CFONTDIR}
	cat kc_fonts.alias >> fonts.alias ;
	cp fonts.alias ..fonts.alias.. ;
	sort ..fonts.alias.. | uniq > fonts.alias ; rm ..fonts.alias..
}
