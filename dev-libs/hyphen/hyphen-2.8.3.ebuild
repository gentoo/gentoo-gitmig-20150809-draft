# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hyphen/hyphen-2.8.3.ebuild,v 1.1 2011/10/16 17:35:24 ssuominen Exp $

EAPI=4

DESCRIPTION="ALTLinux hyphenation library"
HOMEPAGE="http://hunspell.sf.net"
SRC_URI="mirror://sourceforge/hunspell/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

RDEPEND="app-text/hunspell"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README* THANKS TODO"

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default

	insinto /usr/share/doc/${PF}/pdf
	doins doc/*.pdf

	rm -f "${ED}"usr/lib*/libhyphen.la
}
