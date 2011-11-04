# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/subexec/subexec-0.2.0.ebuild,v 1.1 2011/11/04 07:15:52 graaff Exp $

EAPI=4

USE_RUBY="ruby18 ree18 jruby ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem eutils

GITHUB_USER="nulayer"

DESCRIPTION="Subexec spawns an external command with a timeout"
HOMEPAGE="http://github.com/nulayer/subexec"
SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/v${PV} -> ${PN}-git-${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RUBY_S="${GITHUB_USER}-${PN}-*"

ruby_add_bdepend "test? (
	dev-ruby/ruby-debug
	dev-ruby/shoulda
	dev-ruby/rspec:2 )"

all_ruby_prepare() {
	rm Gemfile* || die
	sed -i -e '/[Bb]undler/ s:^:#:' Rakefile || die
	sed -i -e '/begin/,/end/ s:^:#:' spec/spec_helper.rb || die
}
