# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/escm/escm-1.1.ebuild,v 1.3 2006/04/22 15:12:39 hattya Exp $

IUSE=""

DESCRIPTION="escm - Embedded Scheme Processor"
HOMEPAGE="http://www.shiro.dreamhost.com/scheme/vault/escm.html"
SRC_URI="http://www.shiro.dreamhost.com/scheme/vault/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="x86"
SLOT="0"
S="${WORKDIR}/${PN}"

DEPEND="|| (
		dev-lang/gauche
		dev-util/guile
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
