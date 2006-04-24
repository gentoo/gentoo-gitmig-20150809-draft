# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libksba/libksba-0.9.13.ebuild,v 1.2 2006/04/24 14:57:00 agriffis Exp $

DESCRIPTION="makes X.509 certificates and CMS easily accessible to applications"
HOMEPAGE="http://www.gnupg.org/(en)/download/index.html#libksba"
SRC_URI="mirror://gnupg/alpha/libksba/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/libgpg-error-0.7
	dev-libs/libgcrypt"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO VERSION
}
