# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pine-maildir/pine-maildir-4.33.ebuild,v 1.12 2003/09/05 09:09:47 msterret Exp $

DESCRIPTION="Pine, Pico, Pilot, imapd"
HOMEPAGE="http://www.washington.edu/pine/"
SRC_URI="ftp://ftp.cac.washington.edu/pine/pine${PV}.tar.gz
	 http://qmail.nac.net/${P}"

LICENSE="PICO"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="imap"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=sys-libs/pam-0.72"
[ `use imap` ] && PROVIDE="virtual/imap"

S=${WORKDIR}/pine${PV}

src_unpack() {
	unpack pine${PV}.tar.gz
	epatch ${DISTDIR}/${P}
	epatch ${FILESDIR}/${PF}-gentoo.diff
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
