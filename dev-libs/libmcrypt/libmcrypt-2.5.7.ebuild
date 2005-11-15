# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcrypt/libmcrypt-2.5.7.ebuild,v 1.20 2005/11/15 01:21:32 vapier Exp $

inherit eutils libtool

DESCRIPTION="libmcrypt is a library that provides uniform interface to access several encryption algorithms."
HOMEPAGE="http://mcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mcrypt/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ~ppc-macos s390 sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	elibtoolize
}

src_install() {
	dodir /usr/{bin,include,lib}
	einstall || die "install failure"

	dodoc AUTHORS KNOWN-BUGS INSTALL NEWS README THANKS TODO ChangeLog
	dodoc doc/README.* doc/example.c
	prepalldocs
}
