# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/rubygems/rubygems-0.ebuild,v 1.2 2009/12/07 18:29:57 a3li Exp $

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

RDEPEND="ruby_targets_ruby18? ( dev-ruby/rubygems )
	ruby_targets_ruby19? ( dev-lang/ruby:1.9 )
	ruby_targets_jruby? ( dev-java/jruby )"
DEPEND=""
