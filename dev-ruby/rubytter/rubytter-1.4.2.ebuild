# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubytter/rubytter-1.4.2.ebuild,v 1.1 2011/12/25 07:37:08 graaff Exp $

EAPI="2"
# dev-ruby/oauth has only ruby18.
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

RUBY_FAKEGEM_EXTRAINSTALL="VERSION"

inherit ruby-fakegem

DESCRIPTION="Rubytter is a simple twitter library"
HOMEPAGE="http://wiki.github.com/jugyo/rubytter"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/json-1.1.3 >=dev-ruby/oauth-0.3.6"

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"

all_ruby_prepare() {
	sed -i -e '/check_dependencies/ s:^:#:' Rakefile || die
}
