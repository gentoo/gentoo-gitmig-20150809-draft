# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-1.4.4-r1.ebuild,v 1.2 2006/09/20 22:00:38 ticho Exp $

inherit eutils autotools

DESCRIPTION="A TLS 1.0 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="http://josefsson.org/gnutls/releases/${P}.tar.bz2"

# GPL-2 for the gnutls-extras library and LGPL for the gnutls library.
LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc x86"
IUSE="zlib doc"

RDEPEND=">=dev-libs/libgcrypt-1.2.2
	>=app-crypt/opencdk-0.5.5
	zlib? ( >=sys-libs/zlib-1.1 )
	virtual/libc
	>=dev-libs/lzo-2
	dev-libs/libgpg-error
	>=dev-libs/libtasn1-0.3.4
	sys-devel/gettext"
#>=sys-devel/gettext-0.14.5" autoconf indicates this version but it works
# without it
DEPEND="${RDEPEND}
	sys-devel/libtool
	doc? ( dev-util/gtk-doc )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-selflink.patch
	elibtoolize
	eautomake
}

src_compile() {
	local myconf=""

	econf  \
		$(use_with zlib) \
		--without-included-minilzo \
		--without-included-opencdk \
		$(use_enable doc gtk-doc) \
		${myconf} || die
	emake || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS \
		README THANKS doc/TODO

	if use doc ; then
		dodoc doc/README.autoconf doc/tex/gnutls.ps
		docinto examples
		dodoc doc/examples/*.c
	fi
}
