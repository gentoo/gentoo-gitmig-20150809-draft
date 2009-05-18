# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcrypt/libmcrypt-2.5.8-r1.ebuild,v 1.3 2009/05/18 18:51:45 fmccor Exp $

inherit eutils libtool

DESCRIPTION="libmcrypt is a library that provides uniform interface to access several encryption algorithms."
HOMEPAGE="http://mcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mcrypt/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/$P-rotate-mask.patch
	# freebsd?
	elibtoolize
}

src_install() {
	make install DESTDIR="${D}" || die "install failure"

	dodoc AUTHORS NEWS README THANKS TODO ChangeLog
	dodoc doc/README.* doc/example.c
	prepalldocs
}
