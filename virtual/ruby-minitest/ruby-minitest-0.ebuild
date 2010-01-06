# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ruby-minitest/ruby-minitest-0.ebuild,v 1.6 2010/01/06 21:09:17 a3li Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby"

inherit ruby-ng

DESCRIPTION="Virtual ebuild for the Ruby minitest library"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="ruby_targets_ruby18? ( dev-ruby/minitest[ruby_targets_ruby18] )
	ruby_targets_ruby19? ( || ( dev-ruby/minitest[ruby_targets_ruby19] dev-lang/ruby:1.9 ) )
	ruby_targets_jruby? ( dev-ruby/minitest[ruby_targets_jruby] )"
DEPEND=""
