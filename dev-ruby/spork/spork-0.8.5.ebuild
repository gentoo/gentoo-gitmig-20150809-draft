# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/spork/spork-0.8.5.ebuild,v 1.2 2012/06/12 11:45:00 iksaif Exp $

EAPI=2

USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.rdoc"
RUBY_FAKEGEM_EXTRAINSTALL="assets"

inherit ruby-fakegem

DESCRIPTION="Spork is Tim Harper's implementation of test server."
HOMEPAGE="https://github.com/sporkrb/spork"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

ruby_add_bdepend "dev-util/cucumber
	>=dev-ruby/rspec-1.2.9:0
	>=dev-ruby/rspec-rails-1.2.9
	dev-util/cucumber-rails
	>=dev-ruby/rails-2.3
	>=dev-ruby/ruby-debug-0.10.3"

all_ruby_prepare() {
	# Don't use deprecated name in feature file.
	sed -i -e 's/Fonction/Fonctionnalité/' features/cucumber_rails_integration.feature || die

	# Remove failing features when newer Rails versions are
	# installed. This is fixed upstream, but only for the new beta
	# versions and in a way that is too invasive to backport.
	rm features/cucumber_rails_integration.feature \
		features/rspec_rails_integration.feature   \
		features/rails_delayed_loading_workarounds.feature || die
}

each_ruby_test() {
	${RUBY} -S spec spec || die
	${RUBY} -Ilib -S cucumber features || die
}
