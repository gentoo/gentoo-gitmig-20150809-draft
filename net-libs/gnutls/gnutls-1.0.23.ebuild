# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-1.0.23.ebuild,v 1.8 2005/04/01 15:25:45 agriffis Exp $

inherit eutils gnuconfig

DESCRIPTION="A TLS 1.0 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/${P}.tar.gz"

IUSE="zlib doc crypt"
LICENSE="LGPL-2.1 GPL-2"
# GPL-2 for the gnutls-extras library and LGPL for the gnutls library.

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64 ~mips ~alpha ppc64 ~hppa ia64"

# Removed keywords awaiting >=dev-libs/libtasn1-0.2.10 keywords (bug #61944)
# ~ia64

RDEPEND=">=dev-libs/libgcrypt-1.1.94
	crypt? ( >=app-crypt/opencdk-0.5.5 )
	zlib? ( >=sys-libs/zlib-1.1 )
	virtual/libc
	>=dev-libs/lzo-1.0
	>=dev-libs/libtasn1-0.2.10
	dev-libs/libgpg-error"

DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/grep
	sys-devel/gcc
	sys-devel/libtool"


# gnutls has its own version of these. should maybe avoid using.
#	libtasn1
#	opencdk

src_compile() {
	# Needed for mips and probably others
	gnuconfig_update

	local myconf=""
	use crypt || myconf="${myconf} --disable-extra-pki --disable-openpgp-authentication"

	econf  \
		`use_with zlib` \
		--without-included-minilzo \
		--without-included-libtasn1 \
		--without-included-opencdk \
		${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die

	dodoc AUTHORS COPYING COPYING.LIB ChangeLog NEWS \
		README THANKS doc/TODO

	if use doc ; then
		dodoc doc/README.autoconf doc/tex/gnutls.ps
		docinto examples
		dodoc doc/examples/*.c
	fi
}

pkg_postinst() {
	ewarn "An API has changed in gnutls. This is why the library has gone from "
	ewarn "libgnutls.so.10 to libgnutls.so.11."
	ewarn
	ewarn "What is required is a revdep-rebuild."
	ewarn "To show you what is needed to rebuild"
	ewarn "revdep-rebuild --soname libgnutls.so.10 -- -p"
	ewarn ""
	ewarn "Then do:"
	ewarn "revdep-rebuild --soname libgnutls.so.10"
	einfo ""
	einfo "Afterward just try:"
	einfo "revdep-rebuild -- -p"
	einfo "to see if there are any other packages broken."
	einfo "To rebuild these:"
	einfo "revdep-rebuild"

}
