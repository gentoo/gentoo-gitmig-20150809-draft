# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-rc4/ruby-rc4-0.1.4.ebuild,v 1.1 2012/01/28 09:04:24 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A pure Ruby implementation of the Rc4 algorithm."
HOMEPAGE="https://github.com/caiges/Ruby-RC4"
SRC_URI="https://github.com/caiges/Ruby-RC4/tarball/9e70c22a5f05deb0d19b9f91bac4cf2332acaf28 -> ${P}-git.tgz"
RUBY_S="caiges-Ruby-RC4-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

all_ruby_prepare() {
	sed -i -e 's/"README"/"README.md"/' Rakefile || die
}
