# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/fnord/fnord-1.10-r1.ebuild,v 1.4 2008/01/26 17:27:08 bangert Exp $

inherit flag-o-matic eutils

DESCRIPTION="Yet another small httpd."
HOMEPAGE="http://www.fefe.de/fnord/"
SRC_URI="http://www.fefe.de/fnord/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="hppa ppc sparc x86"
IUSE="auth"

DEPEND=""
RDEPEND="${DEPEND}
	sys-process/daemontools
	sys-apps/ucspi-tcp"

pkg_setup() {
	enewuser fnord -1 -1 /etc/fnord nofiles
	enewuser fnordlog -1 -1 /etc/fnord nofiles
}

src_unpack() {
	unpack ${A} && cd "${S}"
	epatch "${FILESDIR}/${PN}"-1.9-gentoo.diff
}

src_compile() {
	# Fix for bug #45716
	replace-sparc64-flags

	use auth && \
		append-flags -DAUTH

	emake DIET="" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install () {
	dobin fnord-conf fnord || die
	dodoc TODO README* SPEED CHANGES
}
