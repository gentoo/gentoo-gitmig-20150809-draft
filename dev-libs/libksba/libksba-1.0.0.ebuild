# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libksba/libksba-1.0.0.ebuild,v 1.7 2007/06/29 12:43:08 angelos Exp $

inherit libtool

DESCRIPTION="makes X.509 certificates and CMS easily accessible to applications"
HOMEPAGE="http://www.gnupg.org/(en)/download/index.html#libksba"
SRC_URI="mirror://gnupg/libksba/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ia64 mips ~ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/libgpg-error-1.2
	dev-libs/libgcrypt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO VERSION
}
