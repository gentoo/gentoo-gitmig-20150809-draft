# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/rubygems/rubygems-0.ebuild,v 1.1 2009/12/06 13:18:58 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby"

inherit ruby-ng

DESCRIPTION="Virtual ebuild for the Ruby gems tools"
HOMEPAGE="http://www.rubygems.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="gentoo_rubylib_ruby18? ( dev-ruby/rubygems )
	gentoo_rubylib_ruby19? ( dev-lang/ruby:1.9 )
	gentoo_rubylib_jruby? ( dev-java/jruby )"
DEPEND=""
