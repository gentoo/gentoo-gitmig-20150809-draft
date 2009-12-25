# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubyforge/rubyforge-2.0.3.ebuild,v 1.3 2009/12/25 09:37:55 graaff Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Simplistic script which automates a limited set of rubyforge operations"
HOMEPAGE="http://codeforpeople.rubyforge.org/rubyforge/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86-fbsd"
IUSE=""

ruby_add_rdepend '>=dev-ruby/json-1.1.7'

ruby_add_bdepend test "virtual/ruby-test-unit dev-ruby/hoe"
ruby_add_bdepend doc dev-ruby/hoe
