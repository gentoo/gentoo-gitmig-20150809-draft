# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/raggle/raggle-0.4.0.ebuild,v 1.4 2007/06/26 03:11:42 mr_bones_ Exp $

inherit ruby

IUSE=""

DESCRIPTION="A console RSS aggregator, written in Ruby"
HOMEPAGE="http://www.raggle.org/"
SRC_URI="http://www.raggle.org/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ~mips ~ppc sparc x86"

USE_RUBY="any"
DEPEND=">=dev-lang/ruby-1.8"
RDEPEND=">=dev-ruby/ncurses-ruby-0.8"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e 's~/usr/local~${D}/usr~' \
		-e '/cp -r \${DOCS}/d' \
		-e "/^DOCDIR/ s/raggle/${PF}/" \
		Makefile || die "sed failed"

	find . -type d -name CVS -exec rm -rf {} \; 2>/dev/null
}
