# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/pine/pine-4.44-r4.ebuild,v 1.5 2002/08/13 01:49:43 gerk Exp $

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
KEYWORDS="x86 ppc"


src_unpack() {
	unpack ${A}

	# RH patches, although I've ignored the "RH" patch itself
	patch -d ${S} -p1 < ${FILESDIR}/pine-4.21-fixhome.patch
	patch -d ${S} -p0 < ${FILESDIR}/imap-4.7c2-flock.patch
	cp ${FILESDIR}/flock.c ${S}/imap/src/osdep/unix
	patch -d ${S} -p1 < ${FILESDIR}/pine-4.21-passwd.patch
	if [ "`use ldap`" ] ; then
		patch -d ${S} -p1 < ${FILESDIR}/pine-4.30-ldap.patch
		mkdir ${S}/ldap
		ln -s /usr/lib ${S}/ldap/libraries
		ln -s /usr/include ${S}/ldap/include
	fi
	patch -d ${S} -p0 < ${FILESDIR}/pine-4.40-boguswarning.patch
	patch -d ${S} -p1 < ${FILESDIR}/pine-4.31-segfix.patch
	patch -d ${S} -p0 < ${FILESDIR}/pine-4.40-lockfile-perm.patch
	patch -d ${S} -p1 < ${FILESDIR}/imap-2000-time.patch
	patch -d ${S} -p1 < ${FILESDIR}/pine-4.33-whitespace.patch
	patch -d ${S} -p1 < ${FILESDIR}/pine-4.44-multibyte.patch
	
	cd ${S}/pine
	cp makefile.lnx makefile.orig
	sed -e "s:-g -DDEBUG:${CFLAGS}:" makefile.orig > makefile.lnx

	cd ${S}/pico
	cp makefile.lnx makefile.orig
	sed -e "s:-g -DDEBUG:${CFLAGS}:" makefile.orig > makefile.lnx
}

src_compile() {                           
	BUILDOPTS=""
	if [ "`use ssl`" ] 
	then
		BUILDOPTS="${BUILDOPTS} SSLDIR=/usr/ssl SSLINCLUDE=/usr/include/openssl"
		BUILDOPTS="${BUILDOPTS} SSLLIB=/usr/lib SSLTYPE=unix"
	else
		BUILDOPTS="${BUILDOPTS} NOSSL"
	fi
	if [ "`use ldap`" ]
	then
		./contrib/ldap-setup lnp lnp
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




