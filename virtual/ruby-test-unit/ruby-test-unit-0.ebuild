# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ruby-test-unit/ruby-test-unit-0.ebuild,v 1.5 2009/12/21 00:06:05 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby"

inherit ruby-ng

DESCRIPTION="Virtual ebuild for the Ruby test/unit library"
HOMEPAGE="http://www.ruby.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="ruby_targets_ruby18? ( || ( dev-ruby/test-unit[ruby_targets_ruby18] dev-lang/ruby:1.8 ) )
	ruby_targets_ruby19? ( dev-ruby/test-unit[ruby_targets_ruby19] )
	ruby_targets_jruby? ( || ( dev-ruby/test-unit[ruby_targets_jruby] dev-java/jruby ) )"
DEPEND=""
