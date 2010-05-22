# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mmap/mmap-0.2.2.ebuild,v 1.2 2010/05/22 15:26:21 flameeyes Exp $

inherit ruby

IUSE=""

DESCRIPTION="The Mmap class implement memory-mapped file objects"
HOMEPAGE="http://moulon.inra.fr/ruby/mmap.html"
SRC_URI="ftp://moulon.inra.fr/pub/ruby/${P}.tar.gz"

SLOT="0"
USE_RUBY="ruby18"
LICENSE="Ruby"
KEYWORDS="x86 alpha ~ppc ~sparc"

DEPEND=">=dev-lang/ruby-1.8"

src_compile() {

	ruby_src_compile all rdoc || die
}
