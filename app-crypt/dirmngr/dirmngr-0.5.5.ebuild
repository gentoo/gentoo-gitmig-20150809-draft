# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/dirmngr/dirmngr-0.5.5.ebuild,v 1.3 2004/08/28 22:56:14 dholm Exp $

DESCRIPTION="DirMngr is a daemon to handle CRL and certificate requests for GnuPG"
HOMEPAGE="http://www.gnupg.org/(en)/download/index.html#dirmngr"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=net-nds/openldap-2.1.26
	>=dev-libs/libgpg-error-0.7
	>=dev-libs/libgcrypt-1.1.94
	>=dev-libs/libassuan-0.6.5
	>=dev-libs/libksba-0.9.6"
RDEPEND=""

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO
}
