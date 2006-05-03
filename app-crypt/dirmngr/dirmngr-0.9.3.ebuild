# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/dirmngr/dirmngr-0.9.3.ebuild,v 1.5 2006/05/03 11:47:08 yoswink Exp $

DESCRIPTION="DirMngr is a daemon to handle CRL and certificate requests for GnuPG"
HOMEPAGE="http://www.gnupg.org/(en)/download/index.html#dirmngr"
SRC_URI="mirror://gnupg/alpha/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls"

RDEPEND=">=net-nds/openldap-2.1.26
	>=dev-libs/libgpg-error-0.7
	>=dev-libs/libgcrypt-1.1.94
	>=dev-libs/libassuan-0.6.8
	>=dev-libs/libksba-0.9.11
	>=dev-libs/pth-1.3.7
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.12.1 )"

src_compile() {
	econf $(use_enable nls) || die "conf failed"
	emake || die 'make failed'
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO
}
