# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libksba/libksba-0.9.8.ebuild,v 1.8 2005/04/01 04:35:59 agriffis Exp $

DESCRIPTION="makes X.509 certificates and CMS easily accessible to applications"
HOMEPAGE="http://www.gnupg.org/(en)/download/index.html#libksba"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/libksba/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ppc64 ~x86 ~sparc ~alpha ia64"
IUSE=""

DEPEND=">=dev-libs/libgpg-error-0.7
	dev-libs/libgcrypt"

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO VERSION
}
