# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/json/json-1.2.0-r1.ebuild,v 1.4 2009/12/25 15:43:01 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_EXTRADOC="CHANGES TODO README"
RUBY_FAKEGEM_DOCDIR="doc"

inherit ruby-fakegem

DESCRIPTION="A JSON implementation as a Ruby extension."
HOMEPAGE="http://json.rubyforge.org/"
LICENSE="|| ( Ruby GPL-2 )"
SRC_URI="mirror://rubygems/${P}.gem"

KEYWORDS="~amd64 ~hppa ~ppc ~x86"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="dev-util/ragel"

each_ruby_compile() {
	${RUBY} -S rake compile_ext || die "extension compile failed"
}

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_newins ext/json/ext/generator.so lib/json/generator.so
	ruby_fakegem_newins ext/json/ext/parser.so lib/json/parser.so
}
