# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/pine/pine-4.58-r3.ebuild,v 1.7 2004/07/22 22:22:14 tgall Exp $

inherit eutils

DESCRIPTION="A tool for reading, sending and managing electronic messages."
HOMEPAGE="http://www.washington.edu/pine/
	http://www.math.washington.edu/~chappa/pine/patches/"
SRC_URI="ftp://ftp.cac.washington.edu/pine/${PN}${PV}.tar.bz2
	mirror://gentoo/${P}-chappa-all-20031108.patch.gz
	http://www.softwolves.pp.se/tmp/${PN}${PV}-utf8-to-singlebyte.patch
	maildir? ( http://hico.fphil.uniba.sk/pine_patches/${P}-maildir.patch )
	ipv6? (
		http://www.ngn.euro6ix.org/IPv6/${PN}/${P}-v6-20031001.diff
		http://www.ngn.euro6ix.org/IPv6/${PN}/readme.${P}-v6-20031001
	)"

LICENSE="PICO"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ppc64"
IUSE="debug ipv6 kerberos ldap maildir passfile ssl"

DEPEND="virtual/libc
	>=sys-apps/sed-4
	>=sys-libs/ncurses-5.1
	>=sys-libs/pam-0.72
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	kerberos? ( app-crypt/mit-krb5 )"

S="${WORKDIR}/${PN}${PV}"

src_unpack() {
	unpack ${A} && cd "${S}"

	# Various fixes and features.
	epatch "${WORKDIR}/${P}-chappa-all-20031108.patch"
	# Fix Home and End keys.
	epatch "${FILESDIR}/pine-4.21-fixhome.patch"
	# UTF8 support.
	epatch "${DISTDIR}/${PN}${PV}-utf8-to-singlebyte.patch"
	# Fix flock() emulation.
	cp "${FILESDIR}/flock.c" "${S}/imap/src/osdep/unix"

	if use maildir ; then
		epatch "${DISTDIR}/${P}-maildir.patch"
		# Build the flock() emulation.
		epatch "${FILESDIR}/imap-4.7c2-flock+maildir.patch"
	else
		# Build the flock() emulation.
		epatch "${FILESDIR}/imap-4.7c2-flock.patch"
	fi
	if use ldap ; then
		# Link to shared ldap libs instead of static.
		epatch "${FILESDIR}/pine-4.30-ldap.patch"
		mkdir "${S}/ldap"
		ln -s /usr/lib "${S}/ldap/libraries"
		ln -s /usr/include "${S}/ldap/include"
	fi
	if use ipv6 ; then
		epatch "${DISTDIR}/${P}-v6-20031001.diff"
	fi
	if use passfile ; then
		epatch "${FILESDIR}/pine-4.56-passfile.patch"
	fi

	# Something from RedHat.
	epatch "${FILESDIR}/pine-4.31-segfix.patch"
	# Create lockfiles with a mode of 0600 instead of 0666.
	epatch "${FILESDIR}/pine-4.40-lockfile-perm.patch"
	# Add missing time.h includes.
	epatch "${FILESDIR}/imap-2000-time.patch"
	# Get rid of stripwhitespace() calls.
	epatch "${FILESDIR}/pine-4.33-whitespace.patch"
	# Bug #23336 - makes pine transparent in terms that support it.
	epatch "${FILESDIR}/transparency.patch"

	if use debug ; then
		sed -e "s:-g -DDEBUG -DDEBUGJOURNAL:${CFLAGS} -g -DDEBUG -DDEBUGJOURNAL:" \
			-i "${S}/pine/makefile.lnx" || die "sed pine/makefile.lnx failed"
		sed -e "s:-g -DDEBUG:${CFLAGS} -g -DDEBUG:" \
			-i "${S}/pico/makefile.lnx" || die "sed pico/makefile.lnx failed"
	else
		sed -e "s:-g -DDEBUG -DDEBUGJOURNAL:${CFLAGS}:" \
			-i "${S}/pine/makefile.lnx" || die "sed pine/makefile.lnx failed"
		sed -e "s:-g -DDEBUG:${CFLAGS}:" \
			-i "${S}/pico/makefile.lnx" || die "sed pico/makefile.lnx failed"
	fi

	sed -e "s:/usr/local/lib/pine.conf:/etc/pine.conf:" \
		-i "${S}/pine/osdep/os-lnx.h" || die "sed os-lnx.h failed"
}

src_compile() {
	local myconf
	if use ssl ; then
		myconf="${myconf} SSLDIR=/usr SSLTYPE=unix SSLCERTS=/etc/ssl/certs"
		sed -e "s:\$(SSLDIR)/certs:/etc/ssl/certs:" \
			-e "s:\$(SSLCERTS):/etc/ssl/certs:" \
			-e "s:-I\$(SSLINCLUDE) ::" \
			-i "${S}/imap/src/osdep/unix/Makefile" || die "sed Makefile failed"
	else
		myconf="${myconf} NOSSL"
	fi
	if use ldap ; then
		./contrib/ldap-setup lnp lnp
		myconf="${myconf} LDAPCFLAGS=-DENABLE_LDAP"
	else
		myconf="${myconf} NOLDAP"
	fi
	if use kerberos ; then
		myconf="${myconf} EXTRAAUTHENTICATORS=gss"
	fi

	./build ${myconf} lnp || die "compile problem"
}

src_install() {
	dobin bin/pine bin/pico bin/pilot bin/mtest bin/rpdump bin/rpload

	insinto /etc
	doins doc/mime.types

	# Only mailbase should install /etc/mailcap
#	donewins doc/mailcap.unx mailcap

	doman doc/pine.1 doc/pico.1 doc/pilot.1 doc/rpdump.1 doc/rpload.1
	dodoc CPYRIGHT README doc/brochure.txt doc/tech-notes.txt
	if use ipv6 ; then
		dodoc "${DISTDIR}/readme.${P}-v6-20031001"
	fi

	docinto imap
	dodoc imap/docs/*.txt imap/docs/CONFIG imap/docs/RELNOTES

	docinto imap/rfc
	dodoc imap/docs/rfc/*.txt

	docinto html/tech-notes
	dohtml -r doc/tech-notes/
}
