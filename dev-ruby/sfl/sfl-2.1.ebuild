# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sfl/sfl-2.1.ebuild,v 1.2 2012/01/08 16:00:58 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="This library provides spawn() which is almost perfectly compatible with ruby 1.9's."
HOMEPAGE="https://github.com/ujihisa/spawn-for-legacy"

LICENSE="|| ( Ruby BSD-2 )"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

all_ruby_prepare() {
	sed -i -e "s:/tmp:${TMPDIR}:" spec/sfl_spec.rb || die
}
