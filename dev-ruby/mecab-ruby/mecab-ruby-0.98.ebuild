# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mecab-ruby/mecab-ruby-0.98.ebuild,v 1.1 2010/01/23 09:04:27 matsuu Exp $

inherit ruby

IUSE=""

DESCRIPTION="Ruby binding for MeCab"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN/-*}/${P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
SLOT="0"

DEPEND=">=app-text/mecab-${PV}"

src_install() {

	ruby_src_install
	dodoc test.rb || die

}
