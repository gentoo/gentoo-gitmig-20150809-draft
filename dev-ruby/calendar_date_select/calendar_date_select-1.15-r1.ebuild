# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/calendar_date_select/calendar_date_select-1.15-r1.ebuild,v 1.3 2010/05/22 15:03:48 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_TASK_DOC="redocs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="Readme.txt History.txt"

RUBY_FAKEGEM_EXTRAINSTALL="public"

inherit ruby-fakegem

DESCRIPTION="A popular and flexible JavaScript DatePicker for RubyOnRails"
HOMEPAGE="http://code.google.com/p/calendardateselect/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
	doc? (
		dev-ruby/activesupport
		dev-ruby/hoe
	)
	test? (
		dev-ruby/activesupport
		dev-ruby/hoe
		dev-ruby/rspec
		dev-ruby/actionpack
	)"
