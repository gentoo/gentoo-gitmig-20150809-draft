# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bcrypt-ruby/bcrypt-ruby-3.0.1.ebuild,v 1.1 2011/10/05 18:20:27 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.md"

inherit multilib ruby-fakegem

DESCRIPTION="An easy way to keep your users' passwords secure."
HOMEPAGE="http://bcrypt-ruby.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

all_ruby_prepare() {
	rm Gemfile || die
}

each_ruby_configure() {
	${RUBY} -Cext/mri extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/mri || die
	cp ext/mri/*$(get_modname) lib/ || die
}
