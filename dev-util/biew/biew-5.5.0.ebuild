# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/biew/biew-5.5.0.ebuild,v 1.9 2004/08/02 18:08:37 spock Exp $

inherit flag-o-matic
IUSE="slang ncurses"

DESCRIPTION="A multiplatform portable viewer of binary files with built-in editor in binary, hexadecimal and disassembler modes."
HOMEPAGE="http://biew.sourceforge.net/"
SRC_URI="mirror://sourceforge/biew/${PN}-550.tar.bz2"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.3 )
	slang? ( >=sys-libs/slang-1.4.9 )"
S="${WORKDIR}/${PN}-550"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i "s/USE_MOUSE=.*/USE_MOUSE=y/" makefile
	sed -i 's:/usr/local:/usr:' biewlib/sysdep/generic/unix/os_dep.c
	sed -i "s/CFLAGS += -O2 -fomit-frame-pointer/CFLAGS +=/" makefile.inc
	sed -i 's/bool/__bool/g' plugins/bin/ne.c
#	sed -i "s/TARGET_OS=.*/TARGET_OS=linux/" makefile
}

src_compile() {
	cd ${S}

	local scrnlib

	if use ncurses ; then
		scrnlib="ncurses"
	elif use slang ; then
		scrnlib="slang"
	else
		scrnlib="vt100"
	fi

	filter-flags -fPIC

	emake 	HOST_CFLAGS="${CFLAGS}" \
		TARGET_SCREEN_LIB=${scrnlib} || die
}

src_install() {
	dobin biew
	dodoc doc/*.txt

	insinto /usr/lib/biew
	doins bin_rc/biew.hlp
	doins bin_rc/skn/standard.skn

	insinto /usr/lib/biew/skn
	doins bin_rc/skn/*

	insinto /usr/lib/biew/xlt
	doins bin_rc/xlt/*
}
