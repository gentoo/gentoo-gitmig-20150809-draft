# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/keylookup/keylookup-2.2.ebuild,v 1.5 2003/09/21 09:44:08 aliz Exp $

DESCRIPTION="A tool to fetch PGP keys from keyservers"
HOMEPAGE="http://www.palfrader.org/keylookup/"
SRC_URI="http://www.palfrader.org/keylookup/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="dev-lang/perl
	app-crypt/gnupg"

src_install() {
	dobin keylookup
	doman keylookup.1
	dodoc COPYING ChangeLog NEWS TODO
}
