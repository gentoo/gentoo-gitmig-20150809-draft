# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/pine-maildir/pine-maildir-4.33.ebuild,v 1.4 2002/07/17 05:07:51 seemant Exp $

S=${WORKDIR}/pine4.33
DESCRIPTION="Pine, Pico, Pilot, imapd"
SRC_URI="ftp://ftp.cac.washington.edu/pine/pine4.33.tar.gz
	 http://qmail.lightwerk.com/pine-maildir-4.33"
HOMEPAGE="http://www.washington.edu/pine/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=sys-libs/pam-0.72"

SLOT="0"
LICENSE="PICO"
KEYWORDS="x86"

if [ "`use imap`" ] ; then
	PROVIDE="virtual/imap"
fi
src_unpack() {
	unpack pine4.33.tar.gz
	patch -p0 < ${DISTDIR}/pine-maildir-4.33 
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
	cd ${S}/pine
	cp makefile.lnx makefile.orig
	sed -e "s:-g -DDEBUG:${CFLAGS}:" makefile.orig > makefile.lnx

	cd ${S}/pico
	cp makefile.lnx makefile.orig
	sed -e "s:-g -DDEBUG:${CFLAGS}:" makefile.orig > makefile.lnx
	
}

src_compile() {													 
	./build slx || die
}

src_install() {															 
	cd ${S}
	into /usr
	dobin bin/pine bin/pico bin/pilot bin/mtest
	dosbin bin/imapd
	if [ "`use imap`" ] ; then
		insinto /usr/include
		doins imap/c-client/{mail,imap4r1,rfc822,linkage}.h
		dolib.a imap/c-client/c-client.a
	fi
	doman doc/pico.1 doc/pine.1

	insinto /etc
	doins doc/mime.types
	donewins doc/mailcap.unx mailcap

	dodoc CPYRIGHT README* doc/brochure.txt doc/tech-notes.txt
	docinto imap
	dodoc imap/docs/*.txt imap/docs/CONFIG imap/docs/FAQ imap/docs/RELNOTES
	docinto imap/rfc
	dodoc imap/docs/rfc/*.txt
	dohtml -r doc
}
