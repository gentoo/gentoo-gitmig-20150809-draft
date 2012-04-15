# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pkg-config/pkg-config-1.1.3.ebuild,v 1.1 2012/04/15 08:08:53 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_TASK_TEST="none"

inherit ruby-fakegem

DESCRIPTION="A pkg-config implementation by Ruby"
HOMEPAGE="https://github.com/rcairo/pkg-config"
LICENSE="|| ( LGPL-2 LGPL-2.1 LGPL-3 )"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE=""

# Requires rcairo to be installed.
RESTRICT="test"

each_ruby_test() {
	${RUBY} test/run-test.rb || die
}
