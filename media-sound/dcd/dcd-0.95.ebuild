# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/dcd/dcd-0.95.ebuild,v 1.15 2006/03/07 14:30:28 flameeyes Exp $

inherit eutils toolchain-funcs

IUSE=""

DESCRIPTION="A simple command-line based CD Player"
HOMEPAGE="http://www.technopagan.org/dcd"
SRC_URI="http://www.technopagan.org/dcd/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="alpha amd64 ~ppc ppc64 sparc x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CDROM="/dev/cdrom" EXTRA_CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin dcd
	doman dcd.1
	dodoc README BUGS ChangeLog
}
