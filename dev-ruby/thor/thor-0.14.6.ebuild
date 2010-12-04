# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/thor/thor-0.14.6.ebuild,v 1.1 2010/12/04 20:40:07 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.md"
RUBY_FAKEGEM_BINWRAP="thor"

inherit ruby-fakegem

DESCRIPTION="A scripting framework that replaces rake and sake"
HOMEPAGE="http://github.com/wycats/thor"

SRC_URI="http://github.com/wycats/${PN}/tarball/v${PV} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/wycats-${PN}-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

ruby_add_bdepend "
	test? ( dev-ruby/fakeweb dev-ruby/rspec:2 )
	doc? ( dev-ruby/rdoc )"

all_ruby_prepare() {
	# Remove Bundler
	rm Gemfile Gemfile.lock || die
	sed -i -e '/[Bb]undler/d' Thorfile || die

	# Remove mandatory coverage collection using simplecov which is not
	# packaged.
	sed -i -e '3,7d' spec/spec_helper.rb || die
}

all_ruby_compile() {
	if use doc; then
		ruby -Ilib bin/thor rdoc || die "RDoc generation failed"
	fi
}

each_ruby_test() {
	${RUBY} -Ilib/ bin/thor spec || die "Tests for ${RUBY} failed"
}
