# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fssm/fssm-0.2.5.ebuild,v 1.3 2011/02/28 00:09:47 ranger Exp $

EAPI=2

USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.markdown"

inherit ruby-fakegem

DESCRIPTION="Monitor API"
HOMEPAGE="http://github.com/ttilley/fssm"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"

each_ruby_prepare() {
	# Remove bundler support
	sed -i -e '/[Bb]undler/d' Rakefile || die
	rm Gemfile || die
}
