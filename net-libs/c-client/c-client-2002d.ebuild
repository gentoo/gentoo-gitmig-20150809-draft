# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/c-client/c-client-2002d.ebuild,v 1.7 2003/12/23 01:20:12 robbat2 Exp $

MY_PN=imap
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="UW IMAP c-client library"
SRC_URI="ftp://ftp.cac.washington.edu/imap/${MY_P}.tar.Z"
HOMEPAGE="http://www.washington.edu/imap/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc ~ppc hppa alpha"
IUSE="ssl"

PROVIDE="virtual/imap-c-client"
RDEPEND="ssl? ( dev-libs/openssl )
		 !virtual/imap-c-client"
DEPEND="${RDEPEND}
		>=sys-libs/pam-0.72"

inherit flag-o-matic

src_unpack() {
	unpack ${A}

	# Tarball packed with bad file perms
	chmod -R ug+w ${S}

	# alpha needs -fPIC
	use alpha && append-flags -fPIC

	# Modifications so we can build it optimially and correctly
	cd ${S}/src/osdep/unix/
	cp Makefile Makefile.orig
	sed \
		-e "s:-g -fno-omit-frame-pointer -O6:${CFLAGS}:g" \
		-e 's:SSLDIR=/usr/local/ssl:SSLDIR=/usr:g' \
		-e 's:SSLCERTS=$(SSLDIR)/certs:SSLCERTS=/etc/ssl/certs:g' \
		< Makefile.orig > Makefile

	# Apply a patch to only build the stuff we need for c-client
	cd ${S}
	patch < ${FILESDIR}/${PV}-Makefile.patch

	# Remove the pesky checks about SSL stuff
	cd ${S}
	cp Makefile Makefile.orig
	grep -v 'read.*exit 1' <Makefile.orig >Makefile
}

src_compile() {
	if use ssl; then
		make lnp SSLTYPE=unix || die
	else
		make lnp SSLTYPE=none || die
	fi
}

src_install() {
	into /usr

	# Library binary
	dolib.a c-client/c-client.a
	dosym /usr/lib/c-client.a /usr/lib/libc-client.a

	# Headers
	insinto /usr/include/imap
	doins c-client/{c-client,mail,imap4r1,rfc822,linkage,misc,smtp,nntp}.h
	doins c-client/{osdep,env_unix,env,fs,ftl,nl,tcp}.h

	# Docs
	dodoc CPYRIGHT README docs/*.txt docs/CONFIG docs/RELNOTES

	docinto rfc
	dodoc docs/rfc/*.txt
}
