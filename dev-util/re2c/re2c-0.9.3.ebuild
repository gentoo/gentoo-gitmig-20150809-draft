# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/re2c/re2c-0.9.3.ebuild,v 1.2 2004/07/17 10:06:39 dholm Exp $

inherit eutils

DESCRIPTION="re2c is a tool for generating C-based recognizers from regular expressions."
HOMEPAGE="http://re2c.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-util/byacc-1.9"

src_unpack() {
	unpack ${A} || die
	# Fix permissions
	chmod -R u+rw ${S}
}

src_compile() {
	# This gets our C(XX)FLAGS in
	export EXTRA_EMAKE="-e"
	econf || die
	emake || die
}

src_install() {
	dobin re2c || die "dobin failed"
	doman re2c.1
	dodoc EADME doc/*
}
