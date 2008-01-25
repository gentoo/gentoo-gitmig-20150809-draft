# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/roundup/roundup-1.4.1.ebuild,v 1.1 2008/01/25 08:49:03 wrobel Exp $

inherit eutils

DESCRIPTION="Simple-to-use and -install issue-tracking system with command-line, web, and e-mail interfaces."
SRC_URI="http://cheeseshop.python.org/packages/source/r/${PN}/${P}.tar.gz"
HOMEPAGE="http://roundup.sourceforge.net"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
LICENSE="as-is"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=sys-libs/db-3.2.9"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# We need to fix the location for man pages (#204308)
	sed -i -e 's#man/man1#share/man/man1#' setup.py
}

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root="${D}" --prefix=/usr || die
	dodoc CHANGES.txt PKG-INFO README.txt doc/*.txt
	dohtml doc/*.html
	dobin "${FILESDIR}"/roundup
}

pkg_postnst() {
	ewarn
	ewarn "As a non privileged user! (not root)"
	ewarn "Run 'roundup-admin install' to set up a roundup instance"
	ewarn "Then edit your config.py file in the tracker home you setup"
	ewarn "Run 'roundup-admin initialise' to setup the admin pass"
	ewarn "run /usr/bin/roundup start port host \"your tracker name\" [your \
tracker home], and all should work!"
	ewarn "run /usr/bin/roundup stop [your tracker home] to stop the server"
	ewarn "log is in [tracker home]/roundup.log"
	ewarn "pid file is in [tracker home]/roundup.pid"
	ewarn
	ewarn "See upgrading.txt for upgrading instructions."
}
