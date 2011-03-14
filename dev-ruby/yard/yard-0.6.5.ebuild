# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/yard/yard-0.6.5.ebuild,v 1.1 2011/03/14 19:16:49 graaff Exp $

EAPI=2

# jruby → fails tests: http://github.com/lsegal/yard/issues/issue/185
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_TEST="specs"
RUBY_FAKEGEM_TASK_DOC="yard"

RUBY_FAKEGEM_EXTRADOC="README.md ChangeLog"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRAINSTALL="templates"

inherit ruby-fakegem

DESCRIPTION="Documentation generation tool for the Ruby programming language"
HOMEPAGE="http://yardoc.org/"

LICENSE="as-is" # truly
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "doc? ( || ( dev-ruby/bluecloth dev-ruby/maruku dev-ruby/rdiscount dev-ruby/kramdown ) )"
ruby_add_bdepend "test? ( dev-ruby/rspec:2 dev-ruby/redcloth )"
