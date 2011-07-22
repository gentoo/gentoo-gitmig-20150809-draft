# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hyphen/hyphen-2.7.1.ebuild,v 1.1 2011/07/22 22:44:47 scarabeus Exp $

EAPI=4

DESCRIPTION="ALTLinux hyphenation library"
HOMEPAGE="http://hunspell.sf.net"
SRC_URI="mirror://sourceforge/hunspell/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="app-text/hunspell"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		--disable-static
}

src_install() {
	default
	dodoc doc/*.pdf
	find "${ED}" -name '*.la' -exec rm -f {} +
}
