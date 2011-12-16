# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/efax/efax-0.9a-r2.ebuild,v 1.2 2011/12/16 14:41:46 ago Exp $

EAPI="2"

inherit eutils

S="${WORKDIR}/${P}-001114"
DESCRIPTION="A simple fax program for single-user systems"
SRC_URI="http://www.cce.com/efax/download/${P}-001114.tar.gz"
HOMEPAGE="http://www.cce.com/efax/"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

src_prepare () {
	epatch "${FILESDIR}/${P}-segfault.patch"

	# remove strip command as per bug #240932
	sed -i -e '/strip/d' Makefile
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "compilation failed"
}

src_install () {
	dobin efax efix fax || die "dobin failed"
	doman efax.1 efix.1 fax.1
	dodoc README
}
