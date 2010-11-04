# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/daemon_controller/daemon_controller-0.2.5.ebuild,v 1.2 2010/11/04 17:31:45 fauli Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.markdown"

inherit ruby-fakegem

DESCRIPTION="A library for starting and stopping specific daemons programmatically in a robust, race-condition-free manner."
HOMEPAGE="http://github.com/FooBarWidget/daemon_controller"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/rspec ) "

each_ruby_test() {
	${RUBY} -S spec spec || die "Tests failed."
}
