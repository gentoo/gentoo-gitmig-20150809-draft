# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/json/json-1.2.0-r1.ebuild,v 1.1 2009/12/20 09:22:22 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="A JSON implementation as a Ruby extension."
HOMEPAGE="http://json.rubyforge.org/"
LICENSE="|| ( Ruby GPL-2 )"
SRC_URI="mirror://rubygems/${P}.gem"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_newins ext/json/ext/generator.so lib/json/generator.so
	ruby_fakegem_newins ext/json/ext/parser.so lib/json/parser.so
}

all_ruby_install() {
	dodoc CHANGES TODO README
}
