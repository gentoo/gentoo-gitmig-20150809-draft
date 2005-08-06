# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libksba/libksba-0.9.6.ebuild,v 1.11 2005/08/06 02:28:49 dragonheart Exp $

DESCRIPTION="KSBA makes X.509 certificates and CMS easily accessible to applications"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/alpha/libksba//${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc-macos ~x86"
IUSE=""

DEPEND=">=dev-libs/libgpg-error-0.7 dev-libs/libgcrypt"

src_compile() {
	econf || die
	make || die
}

src_install(){
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO VERSION
}
