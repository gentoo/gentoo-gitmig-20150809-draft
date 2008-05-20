# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/procinfo/procinfo-18-r1.ebuild,v 1.11 2008/05/20 11:47:41 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A utility to prettyprint /proc/*"
HOMEPAGE="http://www.kozmix.org/src/"
SRC_URI="http://www.kozmix.org/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/kernel-2.6.patch
	epatch "${FILESDIR}"/cpu-usage-fix.patch
	epatch "${FILESDIR}"/${PN}-flags.patch
}

src_compile() {
	# -ltermcap is default and isn't available in gentoo
	# but -lncurses works just as good
	emake CC=$(tc-getCC) LDLIBS=-lncurses || die
}

src_install() {
	dobin procinfo || die
	newbin lsdev.pl lsdev || die
	newbin socklist.pl socklist || die

	doman *.8
	dodoc README CHANGES
}
