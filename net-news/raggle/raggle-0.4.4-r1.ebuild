# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/raggle/raggle-0.4.4-r1.ebuild,v 1.5 2012/04/18 19:04:37 armin76 Exp $

inherit ruby

IUSE=""

DESCRIPTION="A console RSS aggregator, written in Ruby"
HOMEPAGE="http://www.raggle.org/"
SRC_URI="http://www.raggle.org/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ~mips ~ppc x86"

USE_RUBY="ruby18"
DEPEND="=dev-lang/ruby-1.8*"
RDEPEND=">=dev-ruby/ncurses-ruby-0.8"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's~/usr/local~${D}/usr~' \
		-e '/cp -r \${DOCS}/d' \
		-e "/^DOCDIR/ s/raggle/${PF}/" \
		Makefile || die "sed failed"

	sed -i -e 's:#!/usr/bin/env ruby:#!/usr/bin/env ruby18:' raggle \
	|| die "sed failed"
}
