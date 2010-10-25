# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rspec/rspec-2.0.0_beta22.ebuild,v 1.3 2010/10/25 02:08:46 jer Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.markdown"

RUBY_FAKEGEM_VERSION="2.0.0.beta.22"

inherit ruby-fakegem

DESCRIPTION="A Behaviour Driven Development (BDD) framework for Ruby"
HOMEPAGE="http://rspec.rubyforge.org/"
SRC_URI="mirror://rubygems/${PN}-${RUBY_FAKEGEM_VERSION}.gem"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

ruby_add_rdepend "
	~dev-ruby/rspec-core-${PV}
	~dev-ruby/rspec-expectations-${PV}
	~dev-ruby/rspec-mocks-${PV}"
