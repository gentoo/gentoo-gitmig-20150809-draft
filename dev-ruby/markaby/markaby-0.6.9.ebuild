# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/markaby/markaby-0.6.9.ebuild,v 1.1 2010/08/05 05:55:58 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="A templating language for Ruby to write HTML templates in pre Ruby"
HOMEPAGE="http://rubyforge.org/projects/markaby/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit dev-ruby/rspec )"
ruby_add_rdepend ">=dev-ruby/builder-2.0.0"

all_ruby_prepare() {
	# Remove specs for dependencies that we do not yet support
	rm -rf spec/markaby/tilt* || die "Unable to remove specs for unsupported dependencies."
}
