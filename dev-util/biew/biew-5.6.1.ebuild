# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/biew/biew-5.6.1.ebuild,v 1.7 2004/07/20 14:47:39 spock Exp $

IUSE="slang ncurses"

DESCRIPTION="A multiplatform portable viewer of binary files with built-in editor in binary, hexadecimal and disassembler modes."
HOMEPAGE="http://biew.sourceforge.net/"
SRC_URI="mirror://sourceforge/biew/${PN}${PV//./}.tar.bz2"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.3 )
	slang? ( >=sys-libs/slang-1.4.9 )"
S="${WORKDIR}/${PN}-${PV//./}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i "s/USE_MOUSE=.*/USE_MOUSE=y/" makefile
	sed -i 's:/usr/local:/usr:' biewlib/sysdep/generic/unix/os_dep.c
	sed -i "s/CFLAGS += -O2 -fomit-frame-pointer/CFLAGS +=/" makefile.inc
	sed -i 's/bool/__bool/g' plugins/bin/ne.c
#	sed -i "s/TARGET_OS=.*/TARGET_OS=linux/" makefile
}

pkg_setup() {
	if [ -n "`/usr/bin/gcc --version | grep hardened`" ]; then
		eerror "Currently biew doesn't work when GCC is compiled with the 'hardened' USE flag. Sorry."
		die "Exiting"
	fi
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
