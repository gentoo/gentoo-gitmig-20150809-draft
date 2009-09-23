# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/valve/valve-1.0.ebuild,v 1.3 2009/09/23 19:47:04 patrick Exp $

DESCRIPTION="copies data while enforcing a specified maximum transfer rate"
HOMEPAGE="http://www.fourmilab.ch/webtools/valve/"
SRC_URI="http://www.fourmilab.ch/webtools/valve/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

DEPEND=""

src_compile() {
	econf || die "econf failed"
	emake CTANGLE='' CWEAVE='' || die "emake failed"
}

src_install() {
	dobin valve
	doman valve.1
	dodoc README valve.tex valve.pdf
	dohtml index.html logo.png
}

src_test() {
	emake CTANGLE='' CWEAVE='' check || die "check failed"
}
