# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/makepasswd/makepasswd-1.10.ebuild,v 1.19 2004/07/11 02:48:38 pvdabeel Exp $

DESCRIPTION="Random password generator"
HOMEPAGE="http://packages.debian.org/stable/admin/makepasswd.html"
SRC_URI="mirror://debian/dists/potato/main/source/admin/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 ia64 s390 macos"
IUSE=""

RDEPEND="dev-lang/perl"

src_install() {
	dobin makepasswd || die
	doman makepasswd.1
	dodoc README CHANGES
}
