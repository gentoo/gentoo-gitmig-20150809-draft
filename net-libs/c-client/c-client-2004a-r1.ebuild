# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/c-client/c-client-2004a-r1.ebuild,v 1.6 2005/04/01 23:08:47 vapier Exp $

inherit flag-o-matic eutils libtool

MY_PN=imap
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="UW IMAP c-client library"
HOMEPAGE="http://www.washington.edu/imap/"
SRC_URI="ftp://ftp.cac.washington.edu/imap/${MY_P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 sparc x86"
IUSE="ssl pam"

RDEPEND="ssl? ( dev-libs/openssl )
	 !virtual/imap-c-client"
DEPEND="${RDEPEND}
	pam? ( >=sys-libs/pam-0.72 )"
PROVIDE="virtual/imap-c-client"

src_unpack() {
	unpack ${A}

	# Tarball packed with bad file perms
	chmod -R ug+w ${S}

	# lots of things need -fPIC, including various platforms, and this library
	# generally should be built with it anyway.
	append-flags -fPIC

	cd ${S}

	# Modifications so we can build it optimally and correctly
	sed \
		-e "s:BASECFLAGS=\".*\":BASECFLAGS=:g" \
		-e 's:SSLDIR=/usr/local/ssl:SSLDIR=/usr:g' \
		-e 's:SSLCERTS=$(SSLDIR)/certs:SSLCERTS=/etc/ssl/certs:g' \
		-i src/osdep/unix/Makefile || die "Makefile sed fixing failed"

	# Apply a patch to only build the stuff we need for c-client
	epatch ${FILESDIR}/2002d-Makefile.patch || die "epatch failed"

	# Apply this patch conditionally - it adds the compilation of a .so for PHP
	# on the amd64 platform.
	use amd64 && epatch ${FILESDIR}/${P}-amd64-so-fix.patch

	# Remove the pesky checks about SSL stuff
	sed -e '/read.*exit/d' -i Makefile
	elibtoolize
	uclibctoolize
}

src_compile() {
	local ssltype
	use ssl && ssltype="unix" || ssltype="none"
	# no parallel builds supported!
	if use pam ; then
		make lnp SSLTYPE=${ssltype} EXTRACFLAGS="${CFLAGS}" || die "make failed"
	else
		make lnx SSLTYPE=${ssltype} EXTRACFLAGS="${CFLAGS}" || die "make failed"
	fi
}

src_install() {
	into /usr

	# Library binary
	dolib.a c-client/c-client.a
	dosym /usr/$(get_libdir)/c-client.a /usr/$(get_libdir)/libc-client.a

	# Now the shared library created for amd64
	if use amd64; then
		dolib.so c-client/libc-client.so.1.0.0
		cd ${D}/usr/$(get_libdir)
		ln -s libc-client.so.1.0.0 libc-client.so.1
		ln -s libc-client.so.1.0.0 libc-client.so
	fi

	cd ${S}

	# Headers
	insinto /usr/include/imap
	doins c-client/*.h
	doins c-client/linkage.c
	#exclude these dupes (can't do it before now due to symlink hell)
	rm ${D}/usr/include/imap/os_*.h

	# Docs
	dodoc README docs/*.txt docs/CONFIG docs/RELNOTES

	docinto rfc
	dodoc docs/rfc/*.txt
}
