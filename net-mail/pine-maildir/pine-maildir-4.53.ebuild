# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pine-maildir/pine-maildir-4.53.ebuild,v 1.1 2003/05/26 21:21:00 mholzer Exp $

inherit eutils

DESCRIPTION="A tool for reading, sending and managing electronic messages."
SRC_URI="ftp://ftp.cac.washington.edu/pine/pine${PV}.tar.bz2
	mirror://gentoo/${P}"
HOMEPAGE="http://www.washington.edu/pine/"

SLOT="0"
LICENSE="PICO"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="ssl ldap"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=sys-libs/pam-0.72
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	net-www/lynx
	!net-mail/pine"

S=${WORKDIR}/pine${PV}

src_unpack() {
	unpack pine${PV}.tar.bz2
	cd ${S}

	epatch ${DISTDIR}/${P}
	epatch ${FILESDIR}/imap-4.7c2-flock+maildir.patch || die

	# fix for Home and End keys
        epatch ${FILESDIR}/pine-4.21-fixhome.patch || die

        # flock() emulation
        cp ${FILESDIR}/flock.c ${S}/imap/src/osdep/unix

        # change /bin/passwd to /usr/bin/passwd
        epatch ${FILESDIR}/pine-4.21-passwd.patch || die

	if [ "`use ldap`" ] ; then
		# link to shared ldap libs instead of static
		epatch ${FILESDIR}/pine-4.30-ldap.patch || die
		mkdir ${S}/ldap
		ln -s /usr/lib ${S}/ldap/libraries
		ln -s /usr/include ${S}/ldap/include
	fi

	# small flock() related fix
        epatch ${FILESDIR}/pine-4.40-boguswarning.patch || die

        # segfix? not sure what this is for but it still applies
        epatch ${FILESDIR}/pine-4.31-segfix.patch || die

        # change lock files from 0666 to 0600
        epatch ${FILESDIR}/pine-4.40-lockfile-perm.patch || die

        # add missing needed time.h includes
        epatch ${FILESDIR}/imap-2000-time.patch || die

        # gets rid of a call to stripwhitespace()
        epatch ${FILESDIR}/pine-4.33-whitespace.patch || die

	if [ -n "$DEBUG" ]; then
		cd ${S}/pine
		sed -i "s:-g -DDEBUG -DDEBUGJOURNAL:${CFLAGS} -g -DDEBUG -DDEBUGJOURNAL:" \
			makefile.lnx
		cd ${S}/pico
		sed -i "s:-g -DDEBUG:${CFLAGS} -g -DDEBUG:" \
			makefile.lnx
	else
		cd ${S}/pine
		sed -i "s:-g -DDEBUG -DDEBUGJOURNAL:${CFLAGS}:" \
			makefile.lnx
		cd ${S}/pico
		sed -i "s:-g -DDEBUG:${CFLAGS}:" makefile.lnx
	fi

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
	use mbox || dodoc README.maildir

	docinto imap
	dodoc imap/docs/*.txt imap/docs/CONFIG imap/docs/RELNOTES

	docinto imap/rfc
	dodoc imap/docs/rfc/*.txt

	docinto html/tech-notes
	dodoc doc/tech-notes/*.html
}
