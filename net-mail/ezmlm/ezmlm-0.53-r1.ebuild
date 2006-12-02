# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ezmlm/ezmlm-0.53-r1.ebuild,v 1.9 2006/12/02 22:06:06 beandog Exp $

inherit eutils fixheadtails toolchain-funcs

DESCRIPTION="Simple yet powerful mailing list manager for qmail"
HOMEPAGE="http://cr.yp.to/ezmlm.html"
SRC_URI="http://cr.yp.to/software/${P}.tar.gz
	http://csa-net.dk/djbware/ezmlm-0.53-ia64.patch"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc sparc x86"
IUSE=""

DEPEND="sys-apps/groff"
RDEPEND="virtual/qmail"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/ezmlm-0.53-errno.patch
	epatch ${DISTDIR}/ezmlm-0.53-ia64.patch
	epatch ${FILESDIR}/ezmlm-0.53-gcc33.patch
	cd ${S}
	ht_fix_file Makefile *.do
	echo "/usr/bin" > conf-bin
	echo "/usr/share/man" > conf-man
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
}

src_compile() {
	mkdir tmp
	# single thread only to avoid bug in makefile
	make || die
}

src_install () {
	dobin ezmlm-list ezmlm-make ezmlm-manage \
		ezmlm-reject ezmlm-return ezmlm-send \
		ezmlm-sub ezmlm-unsub ezmlm-warn ezmlm-weed \
		|| die

	doman *.1 *.5
}
