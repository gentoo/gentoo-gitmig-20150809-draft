# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/keylookup/keylookup-2.2.ebuild,v 1.8 2004/06/24 21:33:35 agriffis Exp $

DESCRIPTION="A tool to fetch PGP keys from keyservers"
HOMEPAGE="http://www.palfrader.org/keylookup/"
SRC_URI="http://www.palfrader.org/keylookup/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="dev-lang/perl
	app-crypt/gnupg"

src_install() {
	dobin keylookup || die
	doman keylookup.1
	dodoc ChangeLog NEWS TODO
}
