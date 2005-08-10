# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/keylookup/keylookup-2.2.ebuild,v 1.10 2005/08/10 16:58:38 kito Exp $

DESCRIPTION="A tool to fetch PGP keys from keyservers"
HOMEPAGE="http://www.palfrader.org/keylookup/"
SRC_URI="http://www.palfrader.org/keylookup/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~ppc-macos x86"
IUSE=""

RDEPEND="dev-lang/perl
	app-crypt/gnupg"

src_install() {
	dobin keylookup || die
	doman keylookup.1
	dodoc ChangeLog NEWS TODO
}
