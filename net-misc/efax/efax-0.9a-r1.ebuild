# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/efax/efax-0.9a-r1.ebuild,v 1.4 2008/12/30 18:04:51 mpagano Exp $

inherit eutils

S="${WORKDIR}/${P}-001114"
DESCRIPTION="A simple fax program for single-user systems"
SRC_URI="http://www.cce.com/efax/download/${P}-001114.tar.gz"
HOMEPAGE="http://www.cce.com/efax/"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

src_unpack () {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-segfault.patch"

	# remove strip command as per bug #240932
	sed -i -e '/strip/d' Makefile
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" || die "compilation failed"
}

src_install () {
	dobin efax efix fax || die "dobin failed"
	doman efax.1 efix.1 fax.1
	dodoc README
}
