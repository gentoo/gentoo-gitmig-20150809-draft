# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/c-client/c-client-2007f-r1.ebuild,v 1.7 2012/05/29 19:41:34 ranger Exp $

EAPI=4

inherit flag-o-matic eutils libtool toolchain-funcs

MY_PN=imap
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="UW IMAP c-client library"
HOMEPAGE="http://www.washington.edu/imap/"
SRC_URI="ftp://ftp.cac.washington.edu/imap/${MY_P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="doc kernel_linux kernel_FreeBSD pam ssl static-libs"

RDEPEND="ssl? ( dev-libs/openssl )
	!net-mail/uw-imap"
DEPEND="${RDEPEND}
	kernel_linux? ( pam? ( >=sys-libs/pam-0.72 ) )"

src_prepare() {
	# Tarball packed with bad file perms
	chmod -R u+rwX,go-w .

	# lots of things need -fPIC, including various platforms, and this library
	# generally should be built with it anyway.
	append-flags -fPIC

	# Modifications so we can build it optimally and correctly
	sed \
		-e "s:BASECFLAGS=\".*\":BASECFLAGS=:g" \
		-e 's:SSLDIR=/usr/local/ssl:SSLDIR=/usr:g' \
		-e 's:SSLCERTS=$(SSLDIR)/certs:SSLCERTS=/etc/ssl/certs:g' \
		-i src/osdep/unix/Makefile || die "Makefile sed fixing failed"

	# Targets should use the Gentoo (ie linux) fs
	sed -e '/^bsf:/,/^$/ s:ACTIVEFILE=.*:ACTIVEFILE=/var/lib/news/active:g' \
		-i src/osdep/unix/Makefile || die "Makefile sex fixing failed for FreeBSD"

	# Apply a patch to only build the stuff we need for c-client
	epatch "${FILESDIR}"/${PN}-2006k_GENTOO_Makefile.patch

	# Apply patch to add the compilation of a .so for PHP
	# This was previously conditional, but is more widely useful.
	epatch "${FILESDIR}"/${PN}-2006k_GENTOO_amd64-so-fix.patch

	# Remove the pesky checks about SSL stuff
	sed -e '/read.*exit/d' -i Makefile || die

	# Respect LDFLAGS
	epatch "${FILESDIR}"/${PN}-2007e-ldflags.patch
	sed -e "s/CC=cc/CC=$(tc-getCC)/" \
		-e "s/ARRC=ar/ARRC=$(tc-getAR)/" \
		-e "s/RANLIB=ranlib/RANLIB=$(tc-getRANLIB)/" \
		-i src/osdep/unix/Makefile || die "Respecting build flags"

	elibtoolize
}

src_compile() {
	local ssltype target
	use ssl && ssltype="unix" || ssltype="none"
	if use kernel_linux ; then
		use pam && target=lnp || target=lnx
	elif use kernel_FreeBSD ; then
		target=bsf
	fi
	# no parallel builds supported!
	emake -j1 SSLTYPE=${ssltype} $target EXTRACFLAGS="${CFLAGS}" EXTRALDFLAGS="${LDFLAGS}"
}

src_install() {
	if use static-libs; then
		# Library binary
		dolib.a c-client/c-client.a
		dosym c-client.a /usr/$(get_libdir)/libc-client.a
	fi

	# Now the shared library
	dolib.so c-client/libc-client.so.1.0.0

	dosym libc-client.so.1.0.0 /usr/$(get_libdir)/libc-client.so
	dosym libc-client.so.1.0.0 /usr/$(get_libdir)/libc-client.so.1

	# Headers
	insinto /usr/include/imap
	doins src/osdep/unix/*.h
	doins src/c-client/*.h
	doins c-client/linkage.h
	doins c-client/linkage.c
	doins c-client/osdep.h

	# Docs
	dodoc README docs/*.txt docs/BUILD docs/CONFIG docs/RELNOTES docs/SSLBUILD
	if use doc; then
		docinto rfc
		dodoc docs/rfc/*.txt
		docinto draft
		dodoc docs/draft/*
	fi
}
