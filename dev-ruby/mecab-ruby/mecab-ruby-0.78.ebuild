# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mecab-ruby/mecab-ruby-0.78.ebuild,v 1.5 2007/09/09 14:43:02 hattya Exp $

inherit ruby eutils

IUSE=""

DESCRIPTION="Ruby binding for MeCab"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN/-*}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="ppc x86"
SLOT="0"

DEPEND=">=app-text/mecab-${PV}"

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}"/${P}-gentoo.diff

}

src_install() {

	ruby_src_install
	dodoc test.rb || die

}
