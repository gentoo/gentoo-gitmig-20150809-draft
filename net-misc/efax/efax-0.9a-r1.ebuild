# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/efax/efax-0.9a-r1.ebuild,v 1.1 2007/11/04 14:40:26 masterdriverz Exp $

inherit eutils

S="${WORKDIR}/${P}-001114"
DESCRIPTION="A simple fax program for single-user systems"
SRC_URI="http://www.cce.com/efax/download/${P}-001114.tar.gz"
HOMEPAGE="http://www.cce.com/efax/"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

src_unpack () {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:CFLAGS=:CFLAGS=${CFLAGS}:" Makefile
	epatch "${FILESDIR}/${P}-segfault.patch"
}

src_install () {
	dobin efax efix fax
	doman efax.1 efix.1 fax.1
	dodoc README
}
