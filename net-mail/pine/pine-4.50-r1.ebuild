# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pine/pine-4.50-r1.ebuild,v 1.1 2002/11/25 19:34:31 raker Exp $

IUSE="ssl ldap"

S=${WORKDIR}/${PN}${PV}
DESCRIPTION="A tool for reading, sending and managing electronic messages."
SRC_URI="ftp://ftp.cac.washington.edu/${PN}/${PN}${PV}.tar.gz"
HOMEPAGE="http://www.washington.edu/pine/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=sys-libs/pam-0.72
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )"

SLOT="0"
LICENSE="PICO"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64"


src_unpack() {
	unpack ${A}

	# maildir + gentoo patches
	patch -d ${S} -p1 < ${FILESDIR}/4.50-gentoo.diff || die "patch failed"

	if [ "`use ldap`" ] ; then
		# link to shared ldap libs instead of static
		patch -d ${S} -p1 < ${FILESDIR}/pine-4.30-ldap.patch
		mkdir ${S}/ldap
		ln -s /usr/lib ${S}/ldap/libraries
		ln -s /usr/include ${S}/ldap/include
	fi

	if [ -n "$DEBUG" ]; then
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

}

src_compile() {                           
	BUILDOPTS=""
	if [ "`use ssl`" ] 
	then
		BUILDOPTS="${BUILDOPTS} SSLDIR=/usr SSLTYPE=unix SSLCERTS=/etc/ssl/certs"
		cd ${S}/imap/src/osdep/unix
		cp Makefile Makefile.orig
		sed -e "s:$(SSLDIR)/certs:/etc/ssl/certs:" \
			-e "s:$(SSLCERTS):/etc/ssl/certs:" \
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
	dodoc imap/docs/*.txt imap/docs/CONFIG imap/docs/FAQ imap/docs/RELNOTES

	docinto imap/rfc
	dodoc imap/docs/rfc/*.txt

	docinto html/tech-notes
	dodoc doc/tech-notes/*.html
}

