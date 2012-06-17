# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/renameutils/renameutils-0.12.0.ebuild,v 1.4 2012/06/17 19:57:21 jdhore Exp $

EAPI="4"

inherit autotools eutils

DESCRIPTION="Use your favorite text editor to rename files"
HOMEPAGE="http://www.nongnu.org/renameutils/"
SRC_URI="http://savannah.nongnu.org/download/renameutils/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="nls"

DEPEND=">=sys-libs/readline-5.0-r2"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-typo.patch" \
		"${FILESDIR}/${P}-autopoint.patch"
	eautoreconf
}

src_configure() {
	econf $(use_enable nls)
}
