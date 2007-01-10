# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/escm/escm-1.1.ebuild,v 1.5 2007/01/10 19:36:36 peper Exp $

IUSE=""

DESCRIPTION="escm - Embedded Scheme Processor"
HOMEPAGE="http://www.shiro.dreamhost.com/scheme/vault/escm.html"
SRC_URI="http://www.shiro.dreamhost.com/scheme/vault/${P}.tar.gz"

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

	cd ${S}
	sed -i -e "6s/scm, snow/scm gosh, gosh/" configure.in
	autoconf

}

src_install() {

	dobin escm
	doman escm.1
	dodoc ChangeLog escm.html

}
