# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/pine-maildir/pine-maildir-4.21-r1.ebuild,v 1.1 2000/08/08 20:58:39 achim Exp $

P=pine-maildir-4.21
A="pine4.21.tar.gz pine-4.20-maildir_3.patch"
S=${WORKDIR}/pine4.21
CATEGORY="net-mail"
DESCRIPTION="Pine, Pico, Pilot, imapd"
SRC_URI="ftp://ftp.cac.washington.edu/pine/pine4.21.tar.gz
	 ftp://158.195.33.220/pub/pine/pine-4.20-maildir_3.patch"
HOMEPAGE="http://www.washington.edu/pine/
	  ftp://158.195.33.220/pub/pine/pine-4.20-maildir_3.howto.txt"

src_unpack() {
  unpack pine4.21.tar.gz
  cd ${S}
  patch -p1 < ${DISTDIR}/pine-4.20-maildir_3.patch
  cd ${S}/pine
  cp makefile.lnx makefile.orig
  sed -e "s:-g -DDEBUG:${CFLAGS}:" makefile.orig > makefile.lnx

  cd ${S}/pico
  cp makefile.lnx makefile.orig
  sed -e "s:-g -DDEBUG:${CFLAGS}:" makefile.orig > makefile.lnx
  
}

src_compile() {                           
  ./build lnp
}

src_install() {                               
  cd ${S}
  into /usr
  dobin bin/pine bin/pico bin/pilot bin/mtest
  dosbin bin/imapd

  doman doc/pico.1 doc/pine.1

  insinto /etc
  doins doc/mime.types
  newins doc/mailcap.unx mailcap

  dodoc CPYRIGHT README doc/brochure.txt doc/tech-notes.txt
  docinto imap
  dodoc imap/docs/*.txt imap/docs/CONFIG imap/docs/FAQ imap/docs/RELNOTES
  docinto imap/rfc
  dodoc imap/docs/rfc/*.txt
  docinto html/tech-notes
  dodoc doc/tech-notes/*.html
}



