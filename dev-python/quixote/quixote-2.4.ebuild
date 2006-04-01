# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/quixote/quixote-2.4.ebuild,v 1.2 2006/04/01 19:02:34 agriffis Exp $

inherit distutils

MY_P=${P/q/Q}
DESCRIPTION="Python HTML templating framework for developing web applications."
HOMEPAGE="http://www.mems-exchange.org/software/quixote/"
SRC_URI="http://www.mems-exchange.org/software/files/${PN}/${MY_P}.tar.gz"
LICENSE="CNRI-QUIXOTE-2.4"
SLOT="0"
KEYWORDS="~ia64 ~ppc ~ppc-macos ~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.3"

S=${WORKDIR}/${MY_P}
DOCS="ACKS CHANGES LICENSE MANIFEST.in README TODO"

src_install() {
	distutils_src_install
	dodoc doc/*.txt
	dohtml doc/*.html
}

