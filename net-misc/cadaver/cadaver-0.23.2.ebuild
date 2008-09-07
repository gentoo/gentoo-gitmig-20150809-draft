# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cadaver/cadaver-0.23.2.ebuild,v 1.6 2008/09/07 13:46:15 maekke Exp $

inherit eutils

DESCRIPTION="Command-line WebDAV client."
HOMEPAGE="http://www.webdav.org/cadaver"
SRC_URI="http://www.webdav.org/cadaver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc x86"
IUSE="gnutls nls ssl"

DEPEND=">=net-misc/neon-0.27.0"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use ssl && ! built_with_use net-misc/neon ssl ; then
		ewarn "SSL support in cadaver requires SSL support in net-misc/neon."
		ewarn "Please rebuild net-misc/neon with the ssl USE flag if you want to use"
		ewarn "cadaver with SSL support."
		die "SSL support in cadaver requires SSL support in net-misc/neon"
	fi

	if use gnutls && ! built_with_use net-misc/neon gnutls ; then
		ewarn "SSL support in cadaver requires gnutls support in net-misc/neon."
		ewarn "Please rebuild net-misc/neon with the gnutls USE flag if you want to use"
		ewarn "cadaver with gnutls support."
		die "gnutls support in cadaver requires gnutls support in net-misc/neon"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-disable-nls.patch"
}

src_compile() {
	myconf="--with-libs=/usr $(use_enable nls)"
	econf $myconf || die "econf failed"
	emake || die
}

src_install () {
	einstall || die
	dodoc BUGS ChangeLog FAQ NEWS README THANKS TODO
}
