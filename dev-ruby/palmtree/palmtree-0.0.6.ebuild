# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/palmtree/palmtree-0.0.6.ebuild,v 1.1 2007/08/30 01:49:49 nichoj Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Assortment of Capistrano recipes for managing other aspects of your
Rails application such as ferret or backgroundrb servers. These recipes are
designed for the newly upcoming Capistrano 2.0 release."
HOMEPAGE="http://rubyforge.org/projects/palmtree/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="1.2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.5
	>=dev-ruby/capistrano-1.99.1"
