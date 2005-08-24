# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-1.2.4.ebuild,v 1.6 2005/08/24 23:54:10 agriffis Exp $

inherit eutils gnuconfig

DESCRIPTION="A TLS 1.0 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/${P}.tar.bz2"

IUSE="zlib doc crypt"

LICENSE="LGPL-2.1 GPL-2"
# GPL-2 for the gnutls-extras library and LGPL for the gnutls library.

SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86"

# Removed keywords awaiting >=dev-libs/libtasn1-0.2.10 keywords (bug #61944)
#  ~ia64 ~hppa

RDEPEND=">=dev-libs/libgcrypt-1.2.0
	>=app-crypt/opencdk-0.5.5
	zlib? ( >=sys-libs/zlib-1.1 )
	virtual/libc
	>=dev-libs/lzo-1.0
	>=dev-libs/libtasn1-0.2.11
	dev-libs/libgpg-error"


#	crypt? ( >=app-crypt/opencdk-0.5.5 )

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
	# use crypt || myconf="${myconf} --disable-extra-pki --disable-openpgp-authentication"

	econf  \
		`use_with zlib` \
		--without-included-minilzo \
		--without-included-libtasn1 \
		--without-included-opencdk \
		${myconf} || die
	emake || die

	# gtk-doc removed - bug #80906
	# 		`use_enable doc gtk-doc`
}

src_install() {
	# OSX make doesn't handle -jx with x > 1 correctly here.
	# Forcing it to be just one process, solves installation
	# problems that arise here.  Fabian Groffen (2005-07-09)
	if use ppc-macos; then
		emake -j1 DESTDIR=${D} install || die
	else
		emake DESTDIR=${D} install || die
	fi


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
	ewarn "libgnutls.so.11 (or 10) to libgnutls.so.12."
	ewarn
	ewarn "What is required is a revdep-rebuild."
	ewarn "To show you what is needed to rebuild"
	ewarn 'revdep-rebuild --soname-regexp libgnutls.so.1[0-1] -- -p'
	ewarn ""
	ewarn "Then do:"
	ewarn 'revdep-rebuild --soname-regexp libgnutls.so.1[0-1]'
	einfo ""
	einfo "Afterward just try:"
	einfo "revdep-rebuild -- -p"
	einfo "to see if there are any other packages broken."
	einfo "To rebuild these:"
	einfo "revdep-rebuild"

}
