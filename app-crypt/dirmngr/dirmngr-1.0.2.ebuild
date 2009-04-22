# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/dirmngr/dirmngr-1.0.2.ebuild,v 1.5 2009/04/22 18:12:01 armin76 Exp $

DESCRIPTION="DirMngr is a daemon to handle CRL and certificate requests for GnuPG"
HOMEPAGE="http://www.gnupg.org/download/index.en.html#dirmngr"
SRC_URI="mirror://gnupg/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ia64 ~ppc ppc64 sparc x86"
IUSE="nls"

RDEPEND=">=net-nds/openldap-2.1.26
	>=dev-libs/libgpg-error-1.4
	>=dev-libs/libgcrypt-1.2.0
	>=dev-libs/libksba-1.0
	>=dev-libs/pth-1.3.7
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	>=dev-libs/libassuan-0.9.3
	nls? ( >=sys-devel/gettext-0.12.1 )"

src_compile() {
	CFLAGS="${CFLAGS} -DLDAP_DEPRECATED"
	econf --docdir="/usr/share/doc/${PF}" $(use_enable nls) || die "conf failed"
	emake || die 'make failed'
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
