# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/dc-tool-ip/dc-tool-ip-1.0.4.ebuild,v 1.1 2004/11/14 00:55:46 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="ethernet program loader for the Dreamcast"
HOMEPAGE="http://adk.napalm-x.com/dc/dcload-ip/ http://cadcdev.sourceforge.net/"
SRC_URI="mirror://sourceforge/cadcdev/dcload-ip-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="doc"

DEPEND="virtual/libc"

S=${WORKDIR}/dcload-ip-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-bfd-update.patch
	sed -i \
		-e "/^HOSTCC/s:gcc:$(tc-getCC):" \
		-e "/^HOSTCFLAGS/s:-O2:${CFLAGS}:" \
		-e "s:-L/usr/local/dcdev/lib::" \
		-e "s:/usr/local/dcdev/include:.:" \
		Makefile.cfg || die "sed"
}

src_compile() {
	cd ${S}/host-src/tool
	emake || die "tool failed"
}

src_install() {
	dobin host-src/tool/dc-tool || die "tool"
	dodoc README NETWORK CHANGES

	docinto make-cd
	dodoc make-cd/*

	if use doc ; then
		docinto example-src
		dodoc example-src/*
	fi
}
