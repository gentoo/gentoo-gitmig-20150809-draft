# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/lrzsz/lrzsz-0.12.20-r1.ebuild,v 1.10 2007/06/26 02:22:41 mr_bones_ Exp $

inherit flag-o-matic eutils

DESCRIPTION="Communication package providing the X, Y, and ZMODEM file transfer protocols"
HOMEPAGE="http://www.ohse.de/uwe/software/lrzsz.html"
SRC_URI="http://www.ohse.de/uwe/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="nls"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-makefile-smp.patch
	epatch "${FILESDIR}"/${PN}-implicit-decl.patch
}

src_compile() {
	append-flags -Wstrict-prototypes
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_test() {
	#Don't use check target.
	#See bug #120748 before changing this function.
	make vcheck || die "tests failed"
}

src_install() {
	make \
		prefix="${D}/usr" \
		mandir="${D}/usr/share/man" \
		install || die "make install failed"

	local x
	for x in {r,s}{b,x,z} ; do
		dosym l${x} /usr/bin/${x}
	done

	dodoc AUTHORS COMPATABILITY ChangeLog NEWS README* THANKS TODO
}
