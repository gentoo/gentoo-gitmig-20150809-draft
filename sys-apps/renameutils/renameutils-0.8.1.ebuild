# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/renameutils/renameutils-0.8.1.ebuild,v 1.3 2007/07/08 04:46:31 vapier Exp $

inherit eutils autotools

DESCRIPTION="Use your favorite text editor to rename files"
HOMEPAGE="http://www.nongnu.org/renameutils/"
SRC_URI="http://savannah.nongnu.org/download/renameutils/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

DEPEND=">=sys-libs/readline-5.0-r2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
