# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/makepasswd/makepasswd-1.10.ebuild,v 1.15 2004/01/09 15:43:23 agriffis Exp $

DESCRIPTION="Random password generator"
SRC_URI="mirror://debian/dists/potato/main/source/admin/${P/-/_}.orig.tar.gz"
HOMEPAGE="http://packages.debian.org/stable/admin/makepasswd.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ia64 alpha amd64"

RDEPEND="dev-lang/perl"

src_install() {
	dobin makepasswd
	doman makepasswd.1
	dodoc README CHANGES COPYING-2.0
}
