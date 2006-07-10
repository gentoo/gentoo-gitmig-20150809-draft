# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mecab-ruby/mecab-ruby-0.92.ebuild,v 1.1 2006/07/10 05:39:05 usata Exp $

inherit ruby

DESCRIPTION="MeCab library module for Ruby"
HOMEPAGE="http://chasen.org/~taku/software/mecab/"
SRC_URI="mirror://sourceforge.jp/mecab/20899/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2.1 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=app-text/mecab-${PV}"
