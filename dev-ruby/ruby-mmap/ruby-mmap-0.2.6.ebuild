# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-mmap/ruby-mmap-0.2.6.ebuild,v 1.4 2009/05/09 01:16:14 flameeyes Exp $

inherit ruby

IUSE=""

MY_P=${P/ruby-/}

DESCRIPTION="The Mmap class implement memory-mapped file objects"
HOMEPAGE="http://moulon.inra.fr/ruby/mmap.html"
SRC_URI="ftp://moulon.inra.fr/pub/ruby/${MY_P}.tar.gz"

SLOT="0"
USE_RUBY="ruby18"
LICENSE="Ruby"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	if built_with_use --missing false dev-lang/ruby cjk; then
		cd "${S}"
		epatch "${FILESDIR}/${P}-oniguruma_rb_reg_regsub.patch"
	fi
}

src_compile() {
	ruby_src_compile all rdoc || die
}
