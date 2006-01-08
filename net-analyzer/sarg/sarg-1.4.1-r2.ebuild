# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sarg/sarg-1.4.1-r2.ebuild,v 1.9 2006/01/08 15:09:09 pva Exp $

inherit eutils

DESCRIPTION="Squid Analysis Report Generator"
HOMEPAGE="http://sarg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz http://dev.gentoo.org/~eldad/distfiles/sarg-1.4.1-index.sort.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND=">=net-proxy/squid-2.5.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/sarg-1.4.1-index.sort.patch
	epatch ${FILESDIR}/sarg-1.4.1-2.6.fix.patch
}

src_compile() {
	rm -rf config.cache
	./configure \
		--enable-bindir=/usr/bin \
		--enable-mandir=/usr/man/man1 \
		--enable-sysconfdir=/etc/sarg || die "./configure failed"
	emake || die
}

src_install() {
	dodir /etc/sarg /usr/bin /usr/man/man1
	make \
		BINDIR=${D}/usr/bin \
		MANDIR=${D}/usr/man/man1 \
		SYSCONFDIR=${D}/etc/sarg \
		install || die
}
