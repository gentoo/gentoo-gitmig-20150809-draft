# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/escm/escm-1.1.ebuild,v 1.6 2008/06/19 15:21:05 hattya Exp $

inherit autotools

IUSE=""

DESCRIPTION="escm - Embedded Scheme Processor"
HOMEPAGE="http://practical-scheme.net/vault/escm.html"
SRC_URI="http://practical-scheme.net/vault/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="x86"
SLOT="0"
S="${WORKDIR}/${PN}"

DEPEND="|| (
		dev-scheme/gauche
		dev-scheme/guile
	)"

src_unpack() {

	unpack ${A}
	cd "${S}"

	sed -i -e "6s/scm, snow/scm gosh, gosh/" configure.in
	eautoconf

}

src_install() {

	dobin escm
	doman escm.1
	dodoc ChangeLog escm.html

}
