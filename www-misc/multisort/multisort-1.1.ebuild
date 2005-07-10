# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/multisort/multisort-1.1.ebuild,v 1.2 2005/07/10 01:23:03 swegener Exp $

inherit toolchain-funcs

DESCRIPTION="multisort takes any number of httpd logfiles in the Common Log Format and merges them together"
HOMEPAGE="http://www.xach.com/multisort/"
SRC_URI="http://www.xach.com/${PN}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dosbin ${S}/multisort
}
