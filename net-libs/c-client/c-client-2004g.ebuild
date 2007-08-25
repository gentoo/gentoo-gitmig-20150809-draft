# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/c-client/c-client-2004g.ebuild,v 1.11 2007/08/25 14:32:40 vapier Exp $

inherit flag-o-matic eutils libtool

MY_PN=imap
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="UW IMAP c-client library"
HOMEPAGE="http://www.washington.edu/imap/"
SRC_URI="ftp://ftp.cac.washington.edu/imap/${MY_P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="ssl pam kernel_linux kernel_FreeBSD"

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

	# Targets should use the Gentoo (ie linux) fs
	sed -e '/^bsf:/,/^$/ s:ACTIVEFILE=.*:ACTIVEFILE=/var/lib/news/active:g' \
		-i src/osdep/unix/Makefile || die "Makefile sex fixing failed for FreeBSD"

	# Apply a patch to only build the stuff we need for c-client
	epatch ${FILESDIR}/2002d-Makefile.patch || die "epatch failed"

	# Apply patch to add the compilation of a .so for PHP
	# This was previously conditional, but is more widely useful.
	epatch ${FILESDIR}/${PN}-2004a-amd64-so-fix.patch

	# Remove the pesky checks about SSL stuff
	sed -e '/read.*exit/d' -i Makefile
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
	make $target SSLTYPE=${ssltype} EXTRACFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	into /usr

	# Library binary
	dolib.a c-client/c-client.a || die
	dosym c-client.a /usr/$(get_libdir)/libc-client.a

	# Now the shared library
	dolib.so c-client/libc-client.so.1.0.0 || die
	# these are created by ldconfig!
	#cd ${D}/usr/$(get_libdir)
	#ln -s libc-client.so.1.0.0 libc-client.so.1
	#ln -s libc-client.so.1.0.0 libc-client.so

	# Headers
	insinto /usr/include/imap
	doins c-client/*.h
	doins c-client/linkage.c
	#exclude these dupes (can't do it before now due to symlink hell)
	rm "${D}"/usr/include/imap/os_*.h

	# Docs
	dodoc README docs/*.txt docs/CONFIG docs/RELNOTES

	docinto rfc
	dodoc docs/rfc/*.txt
}
