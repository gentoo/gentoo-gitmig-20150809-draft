# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/fnord/fnord-1.9.ebuild,v 1.2 2005/04/09 12:37:57 hansmi Exp $

inherit flag-o-matic eutils

DESCRIPTION="Yet another small httpd."
HOMEPAGE="http://www.fefe.de/fnord/"
SRC_URI="http://www.fefe.de/fnord/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~hppa"
IUSE="diet"

DEPEND="diet?(dev-libs/dietlibc)
	!diet? ( virtual/libc )"

RDEPEND="${DEPEND}
	sys-process/daemontools
	sys-apps/ucspi-tcp"

pkg_setup() {
	enewuser fnord -1 /bin/false /etc/fnord nofiles
	enewuser fnordlog -1 /bin/false /etc/fnord nofiles
}

src_unpack() {
	unpack ${A} && cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	local DIET=""
	use diet && DIET="diet"

	# Fix for bug #45716
	replace-sparc64-flags

	emake DIET="${DIET}" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install () {
	dobin fnord-conf fnord || die
	dodoc TODO README SPEED COPYING CHANGES
}
