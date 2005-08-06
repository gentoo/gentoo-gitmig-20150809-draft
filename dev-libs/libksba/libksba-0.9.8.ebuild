# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libksba/libksba-0.9.8.ebuild,v 1.10 2005/08/06 02:28:49 dragonheart Exp $

inherit eutils

DESCRIPTION="makes X.509 certificates and CMS easily accessible to applications"
HOMEPAGE="http://www.gnupg.org/(en)/download/index.html#libksba"
SRC_URI="mirror://gnupg/alpha/libksba//${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ia64 ~ppc ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/libgpg-error-0.7
	dev-libs/libgcrypt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO VERSION
}
