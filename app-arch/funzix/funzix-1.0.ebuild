# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/funzix/funzix-1.0.ebuild,v 1.3 2008/04/20 06:07:12 vapier Exp $

DESCRIPTION="unpacker for the bogus ZIX format"
HOMEPAGE="http://funzix.sourceforge.net/"
SRC_URI="mirror://sourceforge/funzix/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_install() {
	dobin funzix || die
	dodoc README
}
