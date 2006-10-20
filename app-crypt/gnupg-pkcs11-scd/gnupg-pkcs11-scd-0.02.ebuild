# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg-pkcs11-scd/gnupg-pkcs11-scd-0.02.ebuild,v 1.1 2006/10/20 22:10:47 alonbl Exp $

DESCRIPTION="PKCS#11 support for GnuPG"
HOMEPAGE="http://gnupg-pkcs11.sourceforge.net"
SRC_URI="mirror://sourceforge/gnupg-pkcs11/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/libgpg-error-1.3
	>=dev-libs/libassuan-0.9.2
	>=dev-libs/libgcrypt-1.2.2
	>=dev-libs/openssl-0.9.7"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake install DESTDIR="${D}"
	prepalldocs
}
