# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pine/pine-4.53-r4.ebuild,v 1.6 2003/04/15 16:09:22 mholzer Exp $

inherit eutils

DESCRIPTION="A tool for reading, sending and managing electronic messages."
SRC_URI="ftp://ftp.cac.washington.edu/pine/${PN}${PV}.tar.bz2
	mirror://gentoo//${P}-chappa-20030214.patch.bz2"
HOMEPAGE="http://www.washington.edu/pine/
	http://www.math.washington.edu/~chappa/pine/patches/"

SLOT="0"
LICENSE="PICO"
KEYWORDS="x86 ~ppc sparc ~alpha"
IUSE="ssl ldap"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=sys-libs/pam-0.72
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	!net-mail/pine-maildir"

S=${WORKDIR}/${PN}${PV}

src_unpack() {
	unpack ${PN}${PV}.tar.bz2
	cd ${S}

	epatch ${DISTDIR}/${P}-chappa-20030214.patch.bz2 || die

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

	epatch ${FILESDIR}/pine-4.40-boguswarning.patch

	epatch ${FILESDIR}/pine-4.31-segfix.patch

	epatch ${FILESDIR}/pine-4.40-lockfile-perm.patch

	epatch ${FILESDIR}/imap-2000-time.patch

	epatch ${FILESDIR}/pine-4.33-whitespace.patch

	if [ -n "$DEBUGBUILD" ]; then
 		cd ${S}/pine
		cp makefile.lnx makefile.orig
		sed -e "s:-g -DDEBUG -DDEBUGJOURNAL:${CFLAGS} -g -DDEBUG -DDEBUGJOURNAL:" \
			< makefile.orig > makefile.lnx
		cd ${S}/pico
		cp makefile.lnx makefile.orig
		sed -e "s:-g -DDEBUG:${CFLAGS} -g -DDEBUG:" \
			< makefile.orig > makefile.lnx
	else
		cd ${S}/pine
		cp makefile.lnx makefile.orig
		sed -e "s:-g -DDEBUG -DDEBUGJOURNAL:${CFLAGS}:" \
			< makefile.orig > makefile.lnx
		cd ${S}/pico
		cp makefile.lnx makefile.orig
		sed -e "s:-g -DDEBUG:${CFLAGS}:" makefile.orig > makefile.lnx
	fi
	cd ${S}/pine/osdep
	cp os-lnx.h os-lnx.h.orig
	sed -e "s:/usr/local/lib/pine.conf:/etc/pine.conf:" \
		< os-lnx.h.orig > os-lnx.h
}

src_compile() {                           
	BUILDOPTS=""
	if [ "`use ssl`" ] 
	then
		BUILDOPTS="${BUILDOPTS} SSLDIR=/usr SSLTYPE=unix SSLCERTS=/etc/ssl/certs"
		cd ${S}/imap/src/osdep/unix
		cp Makefile Makefile.orig
		sed \
			-e "s:\$(SSLDIR)/certs:/etc/ssl/certs:" \
			-e "s:\$(SSLCERTS):/etc/ssl/certs:" \
			-e "s:-I\$(SSLINCLUDE) ::" \
			< Makefile.orig > Makefile
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
	dodoc doc/tech-notes/*.html
}
