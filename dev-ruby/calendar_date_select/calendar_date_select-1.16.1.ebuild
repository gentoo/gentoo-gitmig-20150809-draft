# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/calendar_date_select/calendar_date_select-1.16.1.ebuild,v 1.3 2010/08/13 09:38:28 graaff Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"

RUBY_FAKEGEM_EXTRAINSTALL="public"

inherit ruby-fakegem

DESCRIPTION="A popular and flexible JavaScript DatePicker for RubyOnRails"
HOMEPAGE="http://code.google.com/p/calendardateselect/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/rspec >=dev-ruby/actionpack-2.2.0 >=dev-ruby/activesupport-2.3.4:2.3 )"

each_ruby_prepare() {
	sed -i -e 's/2.3.4/~>2.3.4/' spec/spec_helper.rb || die
}

each_ruby_test() {
	${RUBY} -S spec spec/calendar_date_select/* || die "Tests failed."
}
