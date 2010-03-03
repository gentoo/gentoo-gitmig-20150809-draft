# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rspec-rails/rspec-rails-1.2.9.ebuild,v 1.2 2010/03/03 18:54:46 phajdan.jr Exp $

inherit gems

DESCRIPTION="RSpec's official Ruby on Rails plugin"
HOMEPAGE="http://rspec.info/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

USE_RUBY="ruby18"

RDEPEND=">=dev-ruby/rspec-1.2.9
	>=dev-ruby/rack-1.0.0"
DEPEND="${RDEPEND}"
