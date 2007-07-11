# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/quixml/quixml-0.2.1.ebuild,v 1.4 2007/07/11 05:23:08 mr_bones_ Exp $

inherit ruby

USE_RUBY="ruby16 ruby18 ruby19"

DESCRIPTION="A fast Ruby XML API written in C with pretty-printing, entity
en-/decoding, marshalling and regex addressing."
HOMEPAGE="http://quixml.rubyforge.org/"
SRC_URI="http://rubyforge.org/download.php/89/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="hppa ppc sparc x86"
IUSE=""

DEPEND="virtual/ruby
		dev-libs/expat"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc README DOC.html
}
