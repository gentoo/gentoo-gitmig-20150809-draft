# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/autotest-rails/autotest-rails-4.1.0.ebuild,v 1.5 2009/08/09 16:40:16 nixnut Exp $

inherit gems

DESCRIPTION="This is an autotest plugin to provide rails support."
HOMEPAGE="http://rubyforge.org/projects/zentest/"
LICENSE="MIT"

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"

RDEPEND=">=dev-ruby/rubygems-1.3.0
	>=dev-ruby/zentest-4.1.1"
