# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ezmlm/ezmlm-0.53-r1.ebuild,v 1.1 2003/11/30 11:12:03 robbat2 Exp $

inherit eutils fixheadtails

DESCRIPTION="Simple yet powerful mailing list manager for qmail."
SRC_URI="http://cr.yp.to/software/${P}.tar.gz
		http://csa-net.dk/djbware/ezmlm-0.53-ia64.patch"
HOMEPAGE="http://cr.yp.to/software/${PN}.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ppc alpha"

DEPEND="sys-apps/groff"
RDEPEND="|| (	net-mail/qmail
				net-mail/qmail-mysql
				net-mail/qmail-ldap )"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/ezmlm-0.53-errno.patch
	epatch ${DISTDIR}/ezmlm-0.53-ia64.patch
	epatch ${FILESDIR}/ezmlm-0.53-gcc33.patch
	cd ${S}
	ht_fix_file Makefile *.do
	echo "/usr/bin" > conf-bin
	echo "/usr/share/man" > conf-man
	echo "${CC} ${CFLAGS}" > conf-cc
	echo "${CC} ${LDFLAGS}" > conf-ld
}

src_compile() {
	mkdir tmp
	# single thread only to avoid bug in makefile
	make || die
}

src_install () {
	dobin ezmlm-list ezmlm-make ezmlm-manage \
	ezmlm-reject ezmlm-return ezmlm-send \
	ezmlm-sub ezmlm-unsub ezmlm-warn ezmlm-weed

	doman *.1 *.5
}
