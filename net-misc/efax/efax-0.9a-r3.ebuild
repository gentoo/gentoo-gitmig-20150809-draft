# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/efax/efax-0.9a-r3.ebuild,v 1.1 2012/03/03 15:24:42 pacho Exp $

EAPI=4

inherit eutils

S="${WORKDIR}/${P}-001114"

DESCRIPTION="A simple fax program for single-user systems"
HOMEPAGE="http://gentoo.org"
SRC_URI="http://www.cce.com/efax/download/${P}-001114.tar.gz
	mirror://debian/pool/main/e/efax/efax_0.9a-19.diff.gz"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

src_prepare () {
	epatch "${WORKDIR}/${PN}_${PV}-19.diff"
	epatch "${FILESDIR}/${P}-segfault.patch"
	epatch "${FILESDIR}/${P}-fax-command.patch" #327737

	# remove strip command as per bug #240932
	sed -i -e '/strip/d' Makefile
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install () {
	dobin efax efix fax
	doman efax.1 efix.1 fax.1
	dodoc README
}
