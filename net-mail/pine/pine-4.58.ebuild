# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pine/pine-4.58.ebuild,v 1.3 2004/03/25 18:16:10 jhuebel Exp $

inherit eutils

DESCRIPTION="A tool for reading, sending and managing electronic messages."
HOMEPAGE="http://www.washington.edu/pine/
	http://www.math.washington.edu/~chappa/pine/patches/"
SRC_URI="ftp://ftp.cac.washington.edu/pine/${PN}${PV}.tar.bz2"

LICENSE="PICO"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha amd64"
IUSE="ssl ldap debug"

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	>=sys-libs/ncurses-5.1
	>=sys-libs/pam-0.72
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	!net-mail/pine-maildir"

S=${WORKDIR}/${PN}${PV}

src_unpack() {
	unpack ${PN}${PV}.tar.bz2
	cd ${S}

	epatch ${FILESDIR}/pine-4.21-fixhome.patch || die

	epatch ${FILESDIR}/imap-4.7c2-flock.patch
	cp ${FILESDIR}/flock.c ${S}/imap/src/osdep/unix

	if [ "`use ldap`" ] ; then
		# link to shared ldap libs instead of static
		epatch ${FILESDIR}/pine-4.30-ldap.patch
		mkdir ${S}/ldap
		ln -s /usr/lib ${S}/ldap/libraries
		ln -s /usr/include ${S}/ldap/include
	fi

	# Don't appear to need this anymore; as of pine-4.56
	#epatch ${FILESDIR}/pine-4.40-boguswarning.patch

	epatch ${FILESDIR}/pine-4.31-segfix.patch

	epatch ${FILESDIR}/pine-4.40-lockfile-perm.patch

	epatch ${FILESDIR}/imap-2000-time.patch

	epatch ${FILESDIR}/pine-4.33-whitespace.patch

	# bug #23336 - makes pine transparent in terms that support it
	epatch ${FILESDIR}/transparency.patch

	if [ `use debug` ]; then
		cd ${S}/pine
		sed -i \
			-e "s:-g -DDEBUG -DDEBUGJOURNAL:${CFLAGS} -g -DDEBUG -DDEBUGJOURNAL:" \
			makefile.lnx || die "sed pine/makefile.lnx failed"
		cd ${S}/pico
		sed -i \
			-e "s:-g -DDEBUG:${CFLAGS} -g -DDEBUG:" \
			makefile.lnx || die "sed pico/makefile.lnx failed"
	else
		cd ${S}/pine
		cp makefile.lnx makefile.orig
		sed -i \
			-e "s:-g -DDEBUG -DDEBUGJOURNAL:${CFLAGS}:" \
			makefile.lnx || die "sed pine/makefile.lnx failed"
		cd ${S}/pico
		sed -i \
			-e "s:-g -DDEBUG:${CFLAGS}:" \
			makefile.lnx || die "sed pico/makefile.lnx failed"
	fi
	cd ${S}/pine/osdep
	sed -i \
		-e "s:/usr/local/lib/pine.conf:/etc/pine.conf:" \
		os-lnx.h || die "sed os-lnx.h failed"
}

src_compile() {
	BUILDOPTS=""
	if [ "`use ssl`" ]
	then
		BUILDOPTS="${BUILDOPTS} SSLDIR=/usr SSLTYPE=unix SSLCERTS=/etc/ssl/certs"
		cd ${S}/imap/src/osdep/unix
		sed -i \
			-e "s:\$(SSLDIR)/certs:/etc/ssl/certs:" \
			-e "s:\$(SSLCERTS):/etc/ssl/certs:" \
			-e "s:-I\$(SSLINCLUDE) ::" \
			Makefile || die "sed Makefile failed"
		cd ${S}
	else
		BUILDOPTS="${BUILDOPTS} NOSSL"
	fi
	if [ "`use ldap`" ]
	then
		./contrib/ldap-setup lnp lnp
		BUILDOPTS="${BUILDOPTS} LDAPCFLAGS=-DENABLE_LDAP"
	else
		BUILDOPTS="${BUILDOPTS} NOLDAP"
	fi

	./build ${BUILDOPTS} lnp || die
}

src_install() {
	into /usr
	dobin bin/pine bin/pico bin/pilot bin/mtest bin/rpdump bin/rpload

	doman doc/pine.1 doc/pico.1 doc/pilot.1 doc/rpdump.1 doc/rpload.1

	insinto /etc
	doins doc/mime.types
	donewins doc/mailcap.unx mailcap

	dodoc CPYRIGHT README doc/brochure.txt doc/tech-notes.txt

	docinto imap
	dodoc imap/docs/*.txt imap/docs/CONFIG imap/docs/RELNOTES

	docinto imap/rfc
	dodoc imap/docs/rfc/*.txt

	docinto html/tech-notes
	dohtml -r doc/tech-notes/
}
